#!/usr/bin/env python3
"""Check links in the built site.

    ./scripts/check-links.sh                 # internal links and anchors (strict)
    ./scripts/check-links.sh --external      # also probe external URLs (best effort)
    ./scripts/check-links.sh --root public   # default root

Internal links must resolve to a file in the built site, and `#fragment` targets
must exist as an `id` (or `name`) in the destination page. External URLs are only
probed with `--external`: 4xx/5xx responses are reported as warnings, because
several of our targets (App Store listings, Bluesky) bot-wall automated requests
and a red CI run would just be noise.

Exit status is 1 when an internal link or anchor is broken, or when an external
URL is unreachable and `--strict-external` is set.
"""

from __future__ import annotations

import argparse
import html.parser
import pathlib
import re
import sys
import urllib.error
import urllib.parse
import urllib.request

# Link targets we intentionally do not resolve.
SKIP_SCHEMES = ("mailto:", "tel:", "javascript:", "data:", "sms:")


class PageParser(html.parser.HTMLParser):
    """Collect hrefs/srcs and the ids a page defines."""

    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.links: list[tuple[str, str]] = []  # (tag, value)
        self.ids: set[str] = set()

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        a = dict(attrs)
        if a.get("id"):
            self.ids.add(a["id"])  # type: ignore[arg-type]
        if tag == "a" and a.get("name"):
            self.ids.add(a["name"])  # type: ignore[arg-type]
        if tag in ("a", "area") and a.get("href"):
            self.links.append((tag, a["href"]))  # type: ignore[arg-type]
        elif tag in ("img", "script", "iframe", "source") and a.get("src"):
            self.links.append((tag, a["src"]))  # type: ignore[arg-type]
        elif tag == "link" and a.get("href") and "stylesheet" in (a.get("rel") or ""):
            self.links.append((tag, a["href"]))  # type: ignore[arg-type]


def page_url(root: pathlib.Path, path: pathlib.Path) -> str:
    """URL path of a file in the built site, e.g. /units2units/ for index.html."""
    rel = path.relative_to(root).as_posix()
    if rel == "index.html":
        return "/"
    if rel.endswith("/index.html"):
        return "/" + rel[: -len("index.html")]
    return "/" + rel


def resolve(root: pathlib.Path, base_url: str, href: str) -> tuple[pathlib.Path | None, str | None]:
    """Map an internal href to (file, fragment). None file means it is not internal."""
    parsed = urllib.parse.urlsplit(href)
    if parsed.scheme or parsed.netloc:
        return None, None
    if href.startswith(SKIP_SCHEMES) or href.startswith("#"):
        # Same-page fragment: the caller resolves it against base_url.
        return root / base_url.lstrip("/") / "index.html" if base_url.endswith("/") else None, parsed.fragment or None
    path = urllib.parse.unquote(parsed.path)
    if not path:
        target_url = base_url
    elif path.startswith("/"):
        target_url = path
    else:
        target_url = urllib.parse.urljoin(base_url, path)

    rel = urllib.parse.unquote(target_url).lstrip("/")
    candidate = root / rel
    if target_url.endswith("/"):
        candidate = candidate / "index.html"
    elif candidate.is_dir():
        candidate = candidate / "index.html"
    elif not candidate.suffix:
        # /foo  ->  /foo/index.html first, then /foo.html
        if (root / rel / "index.html").exists():
            candidate = root / rel / "index.html"
        elif (root / f"{rel}.html").exists():
            candidate = root / f"{rel}.html"
    return candidate, parsed.fragment or None


def probe_external(url: str, retries: int = 2) -> tuple[str | None, int | None]:
    """Return (error message, status). Error is None when the request succeeded."""
    request = urllib.request.Request(url, method="GET", headers={"User-Agent": "gnitoapp-link-check"})
    last = None
    for _ in range(retries + 1):
        try:
            with urllib.request.urlopen(request, timeout=15) as response:
                return None, response.status
        except urllib.error.HTTPError as exc:
            last = f"HTTP {exc.code}"
            if 400 <= exc.code < 500:
                return last, exc.code
        except Exception as exc:  # network errors, TLS, timeouts
            last = str(exc)[:120]
    return last, None


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--root", default="public", help="built site directory (default: public)")
    parser.add_argument("--external", action="store_true", help="probe external URLs too (best effort)")
    parser.add_argument("--strict-external", action="store_true", help="fail when an external probe fails")
    args = parser.parse_args()

    root = pathlib.Path(args.root)
    if not root.is_dir():
        print(f"error: {root} does not exist - build the site first", file=sys.stderr)
        return 2

    pages = sorted(root.rglob("*.html"))
    if not pages:
        print(f"error: no HTML files under {root}", file=sys.stderr)
        return 2

    parsed: dict[pathlib.Path, PageParser] = {}
    for page in pages:
        doc = PageParser()
        doc.feed(page.read_text(errors="ignore"))
        parsed[page] = doc

    broken: list[str] = []
    external: dict[str, str | None] = {}
    checked = 0

    for page, doc in parsed.items():
        base = page_url(root, page)
        for tag, href in doc.links:
            href = href.strip()
            if not href or href.startswith(SKIP_SCHEMES):
                continue
            if re.match(r"^(https?:)?//", href):
                absolute = href if href.startswith("http") else "https:" + href
                if args.external and absolute not in external:
                    error, _ = probe_external(absolute)
                    external[absolute] = error
                continue
            if href.startswith("#"):
                fragment = href[1:]
                if fragment and fragment not in doc.ids:
                    broken.append(f"{base}: anchor #{fragment} not defined on the page")
                continue
            target, fragment = resolve(root, base, href)
            if target is None:
                continue
            checked += 1
            if not target.exists():
                broken.append(f"{base}: {href} -> {target.relative_to(root)} does not exist")
                continue
            if fragment and target.suffix == ".html":
                target_doc = parsed.get(target)
                if target_doc is None:
                    target_doc = PageParser()
                    target_doc.feed(target.read_text(errors="ignore"))
                if fragment not in target_doc.ids:
                    broken.append(f"{base}: {href} -> anchor #{fragment} not defined in {target.relative_to(root)}")

    failed_external = {url: err for url, err in external.items() if err}

    print(f"checked {checked} internal link(s) across {len(pages)} page(s)")
    if args.external:
        print(f"probed {len(external)} external URL(s), {len(failed_external)} unreachable")

    if broken:
        print(f"\n{len(broken)} broken internal link(s):", file=sys.stderr)
        for line in broken:
            print(f"  - {line}", file=sys.stderr)

    if failed_external:
        prefix = "ERROR" if args.strict_external else "warning"
        print(f"\n{prefix}: {len(failed_external)} external URL(s) could not be fetched:", file=sys.stderr)
        for url, err in sorted(failed_external.items()):
            print(f"  - {url}: {err}", file=sys.stderr)

    if broken or (args.strict_external and failed_external):
        return 1
    print("link check passed")
    return 0


if __name__ == "__main__":
    sys.exit(main())
