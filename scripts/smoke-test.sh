#!/usr/bin/env python3
"""Smoke-test the deployed site.

    ./scripts/smoke-test.sh https://gnitoapp.com

Run after a deploy. It checks what a deploy can silently break: canonical URLs,
the product page's download button/version/checksum, the SHA256SUMS file, the
APK itself, the robots sitemap line, and the sitemap's scheme.

Requests carry a cache-busting query string because GitHub Pages caches HTML for
up to 10 minutes; without it a just-deployed change would look like a failure.
"""

from __future__ import annotations

import json
import pathlib
import re
import sys
import time
import urllib.error
import urllib.request

ROOT = pathlib.Path(__file__).resolve().parent.parent
CACHE_BUST = f"smoke={int(time.time())}"


def fetch(url: str, method: str = "GET") -> tuple[int, str]:
    request = urllib.request.Request(url, method=method, headers={"User-Agent": "gnitoapp-smoke"})
    try:
        with urllib.request.urlopen(request, timeout=30) as response:
            body = response.read() if method == "GET" else b""
            return response.status, body.decode("utf-8", "ignore")
    except urllib.error.HTTPError as exc:
        return exc.code, ""
    except Exception as exc:  # network, TLS, timeout
        return 0, str(exc)


def check(condition: bool, message: str, problems: list[str]) -> None:
    print(("ok   " if condition else "FAIL ") + message)
    if not condition:
        problems.append(message)


def main() -> int:
    if len(sys.argv) != 2:
        print(__doc__)
        return 2
    base = sys.argv[1].rstrip("/")
    # Assertions are about the *published* origin (canonical, sitemap, robots),
    # while `base` may be a local server when rehearsing the check.
    config = (ROOT / "hugo.yaml").read_text()
    match = re.search(r"^baseURL:\s*(\S+)", config, re.M)
    origin = (match.group(1) if match else base).rstrip("/")
    data_file = ROOT / "data" / "apk_checksums.json"
    if not data_file.exists():
        print(f"error: {data_file} is missing", file=sys.stderr)
        return 2
    apps = json.loads(data_file.read_text())
    problems: list[str] = []

    status, home = fetch(f"{base}/?{CACHE_BUST}")
    check(status == 200, f"{base}/ returns 200 (got {status})", problems)
    check(f"rel=canonical href={origin}/" in home or f'rel="canonical" href="{origin}/"' in home,
          f"home page canonical is {origin}/", problems)

    for product, entry in sorted(apps.items()):
        status, page = fetch(f"{base}/{product}/?{CACHE_BUST}")
        check(status == 200, f"/{product}/ returns 200 (got {status})", problems)
        check(f"/{product}/{entry['apk']}" in page,
              f"/{product}/ links {entry['apk']}", problems)
        check(f"Download APK {entry['version']}" in page,
              f"/{product}/ shows version {entry['version']}", problems)
        check(entry["sha256"] in page, f"/{product}/ publishes the SHA-256", problems)
        check(f"/{product}/SHA256SUMS" in page, f"/{product}/ links SHA256SUMS", problems)

        status, sums = fetch(f"{base}/{product}/SHA256SUMS?{CACHE_BUST}")
        expected = f"{entry['sha256']}  {entry['apk']}"
        check(status == 200 and sums.strip() == expected,
              f"/{product}/SHA256SUMS matches data/apk_checksums.json", problems)

        status, _ = fetch(f"{base}/{product}/{entry['apk']}", method="HEAD")
        check(status == 200, f"/{product}/{entry['apk']} is downloadable (got {status})", problems)

    status, robots = fetch(f"{base}/robots.txt?{CACHE_BUST}")
    check(status == 200 and f"Sitemap: {origin}/sitemap.xml" in robots,
          "robots.txt advertises the sitemap", problems)

    status, sitemap = fetch(f"{base}/sitemap.xml?{CACHE_BUST}")
    check(status == 200 and f"<loc>{origin}/" in sitemap,
          "sitemap uses the published origin", problems)
    check("<loc>http://" not in sitemap, "sitemap has no http:// URLs", problems)

    if problems:
        print(f"\n{len(problems)} smoke check(s) failed", file=sys.stderr)
        return 1
    print(f"\nall smoke checks passed for {base}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
