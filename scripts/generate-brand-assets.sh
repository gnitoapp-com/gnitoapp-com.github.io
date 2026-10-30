#!/usr/bin/env python3
"""Generate the brand image set from the master logo.

    ./scripts/generate-brand-assets.sh

Source: assets/images/logo/gnitoapp-com-logo.png (square, brand red).

Outputs (all generated — never hand-edited):
    static/favicon.ico, static/favicon-NxN.png, static/apple-touch-icon.png
    static/android-chrome-NxN.png, static/site.webmanifest
    assets/icons/logo.png                     (navbar mark, 64px for 2x displays)
    static/og/<site|product>.png              (1200x630 social cards)

Docsy discovers the favicons by their conventional names in `static/` (see the
theme's favicons.html); the manifest and social cards are linked from
layouts/partials/hooks/head-end.html and the page front matter.

Re-run after changing the master logo; the product cards read the name, tagline
and logo path from data/products/*.yaml so they cannot drift from the pages.
"""

from __future__ import annotations

import json
import pathlib
import re
import sys

from PIL import Image, ImageDraw, ImageFont

ROOT = pathlib.Path(__file__).resolve().parent.parent
SOURCE = ROOT / "assets" / "images" / "logo" / "gnitoapp-com-logo.png"
STATIC = ROOT / "static"
PRODUCTS = ROOT / "data" / "products"
ICONS = ROOT / "assets" / "icons"
OG = STATIC / "og"

BRAND = (166, 1, 7)  # sampled from the master logo's background
CARD_BG = (20, 24, 30)  # matches the site's dark surface
WHITE = (255, 255, 255)
FONT_BOLD = "/usr/share/fonts/google-carlito-fonts/Carlito-Bold.ttf"
FONT_REGULAR = "/usr/share/fonts/google-carlito-fonts/Carlito-Regular.ttf"

FAVICON_SIZES = (16, 32, 48, 96, 192)
MASKABLE_SIZES = (192, 512)


def load_source() -> Image.Image:
    if not SOURCE.exists():
        sys.exit(f"error: master logo missing: {SOURCE}")
    return Image.open(SOURCE).convert("RGBA")


def square(im: Image.Image, size: int) -> Image.Image:
    return im.resize((size, size), Image.LANCZOS)


def maskable(im: Image.Image, size: int, content_ratio: float = 0.8) -> Image.Image:
    """Android maskable icon: content inside the 80% safe zone, brand background."""
    canvas = Image.new("RGBA", (size, size), BRAND + (255,))
    inner = int(size * content_ratio)
    canvas.alpha_composite(square(im, inner), ((size - inner) // 2, (size - inner) // 2))
    return canvas


def rounded(im: Image.Image, radius_ratio: float = 0.18) -> Image.Image:
    mask = Image.new("L", im.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle(
        (0, 0, im.size[0] - 1, im.size[1] - 1), radius=int(im.size[0] * radius_ratio), fill=255
    )
    out = im.copy()
    out.putalpha(mask)
    return out


def wrap(draw: ImageDraw.ImageDraw, text: str, font: ImageFont.FreeTypeFont, width: int) -> list[str]:
    words, lines, line = text.split(), [], ""
    for word in words:
        candidate = f"{line} {word}".strip()
        if draw.textlength(candidate, font=font) <= width:
            line = candidate
        else:
            if line:
                lines.append(line)
            line = word
    if line:
        lines.append(line)
    return lines


def og_card(out: pathlib.Path, name: str, tagline: str, logo: Image.Image | None) -> None:
    card = Image.new("RGB", (1200, 630), CARD_BG)
    draw = ImageDraw.Draw(card)
    title_font = ImageFont.truetype(FONT_BOLD, 64)
    sub_font = ImageFont.truetype(FONT_REGULAR, 34)
    foot_font = ImageFont.truetype(FONT_REGULAR, 26)

    # Brand accent bar, then the app icon itself (its own backdrop is part of the
    # icon; no white frame needed on a dark card).
    draw.rectangle((0, 0, 1200, 10), fill=BRAND)
    x = 100
    mark = rounded(logo if logo is not None else square(load_source(), 200))
    mark = mark.resize((200, 200), Image.LANCZOS)
    card.paste(mark, (x, 90), mark)

    y = 330
    for line in wrap(draw, name, title_font, 1000):
        draw.text((x, y), line, font=title_font, fill=WHITE)
        y += 78
    for line in wrap(draw, tagline, sub_font, 1000)[:2]:
        draw.text((x, y + 8), line, font=sub_font, fill=(200, 208, 218))
        y += 44

    draw.text((x, 548), "gnitoapp.com", font=foot_font, fill=(235, 120, 120))
    card.save(out, "PNG", optimize=True)
    print(f"  {out.relative_to(ROOT)} ({out.stat().st_size // 1024} KB)")


def read_product(path: pathlib.Path) -> dict[str, str]:
    text = path.read_text()
    def field(name: str) -> str:
        m = re.search(rf"^{name}:\s*(.+)$", text, re.M)
        return m.group(1).strip().strip('"') if m else ""
    return {"name": field("name"), "tagline": field("tagline"), "logo": field("logo")}


def main() -> int:
    src = load_source()
    STATIC.mkdir(exist_ok=True)
    ICONS.mkdir(parents=True, exist_ok=True)
    OG.mkdir(parents=True, exist_ok=True)

    print("favicons:")
    for size in FAVICON_SIZES:
        out = STATIC / f"favicon-{size}x{size}.png"
        square(src, size).save(out, "PNG", optimize=True)
        print(f"  {out.name}")

    ico = STATIC / "favicon.ico"
    square(src, 256).save(ico, sizes=[(s, s) for s in (16, 32, 48)])
    print(f"  {ico.name} (16/32/48)")

    (STATIC / "apple-touch-icon.png").write_bytes(b"")
    square(src, 180).convert("RGB").save(STATIC / "apple-touch-icon.png", "PNG", optimize=True)
    print("  apple-touch-icon.png (180)")

    for size in MASKABLE_SIZES:
        out = STATIC / f"android-chrome-{size}x{size}.png"
        maskable(src, size).save(out, "PNG", optimize=True)
        print(f"  {out.name} (maskable)")

    print("navbar mark:")
    square(src, 64).save(ICONS / "logo.png", "PNG", optimize=True)
    print("  assets/icons/logo.png (64)")

    manifest = {
        "name": "GnitoApp.com",
        "short_name": "GnitoApp",
        "description": "Apps for Android, iOS and the web, built by GnitoApp.com.",
        "start_url": "/",
        "display": "standalone",
        "background_color": "#a60107",
        "theme_color": "#a60107",
        "icons": [
            {"src": "/android-chrome-192x192.png", "sizes": "192x192", "type": "image/png", "purpose": "maskable"},
            {"src": "/android-chrome-512x512.png", "sizes": "512x512", "type": "image/png", "purpose": "maskable"},
            {"src": "/favicon-192x192.png", "sizes": "192x192", "type": "image/png", "purpose": "any"},
        ],
    }
    (STATIC / "site.webmanifest").write_text(json.dumps(manifest, indent=2) + "\n")
    print("  site.webmanifest")

    print("social cards (1200x630):")
    og_card(OG / "gnitoapp-com.png", "GnitoApp.com", "Apps for Android, iOS and the web.", None)
    for yaml_file in sorted(PRODUCTS.glob("*.yaml")):
        product = read_product(yaml_file)
        logo_path = ROOT / "static" / product["logo"].lstrip("/")
        logo = Image.open(logo_path).convert("RGBA") if logo_path.exists() else None
        og_card(OG / f"{yaml_file.stem}.png", product["name"], product["tagline"], logo)

    return 0


if __name__ == "__main__":
    sys.exit(main())
