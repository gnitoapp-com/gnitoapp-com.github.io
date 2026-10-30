#!/usr/bin/env python3
"""Generate (or verify) the APK integrity data published with each download.

    ./scripts/apk-checksums.sh                    # rewrite data + SHA256SUMS files
    ./scripts/apk-checksums.sh --check            # verify committed data matches the APKs
    ./scripts/apk-checksums.sh --rendered public  # verify the built pages link them

Outputs, per product:

    static/<product>/SHA256SUMS     sha256sum-compatible, next to the APK
    data/apk_checksums.json        rendered on the landing page by the
                                   {{< apk-checksum "<product>" >}} shortcode

The signing-certificate fingerprint is read with `apksigner` and the APK's
identity with `aapt2`, both from an Android SDK build-tools directory when one
is installed (ANDROID_HOME, ~/Android/Sdk, ~/Library/Android/sdk, or PATH).
They are optional: --check works with plain Python, so CI enforces that the
committed checksums still match the APK without needing an Android SDK.

--check fails (exit 1) on: a missing/stale entry, a SHA256SUMS mismatch, a
version.json that disagrees with the APK filename, or missing product data.

--rendered fails (exit 1) on a built page that does not link the current APK,
show its version, carry its SHA-256, or link its SHA256SUMS file.
"""

from __future__ import annotations

import argparse
import glob
import hashlib
import json
import os
import pathlib
import re
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
STATIC = ROOT / "static"
DATA = ROOT / "data" / "apk_checksums.json"
CONTENT = ROOT / "content" / "en"


def die(msg: str) -> "NoReturn":  # type: ignore[valid-type]
    print(f"error: {msg}", file=sys.stderr)
    sys.exit(1)


def sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as fh:
        for chunk in iter(lambda: fh.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def find_android_tool(name: str) -> str | None:
    if found := shutil.which(name):
        return found
    roots = [
        os.environ.get("ANDROID_HOME"),
        os.environ.get("ANDROID_SDK_ROOT"),
        str(Path.home() / "Android" / "Sdk"),
        str(Path.home() / "Library" / "Android" / "sdk"),
    ]
    for root in filter(None, roots):
        candidates = sorted(glob.glob(f"{root}/build-tools/*/{name}"), reverse=True)
        if candidates:
            return candidates[0]
    return None


def read_version(product_dir: Path) -> dict:
    version_file = product_dir / "version.json"
    if not version_file.exists():
        die(f"{version_file.relative_to(ROOT)} is missing")
    data = json.loads(version_file.read_text())
    for key in ("version", "buildNumber"):
        if key not in data:
            die(f"{version_file.relative_to(ROOT)} has no {key!r}")
    return data


def apk_filename(version: str) -> str:
    return version.replace(".", "_")


def signer_info(apk: Path, apksigner: str | None) -> tuple[str | None, str | None]:
    if not apksigner:
        return None, None
    # apksigner prints JVM native-access warnings on stderr; the data is on stdout.
    proc = subprocess.run(
        [apksigner, "verify", "--print-certs", str(apk)],
        capture_output=True,
        text=True,
        check=False,
    )
    if proc.returncode != 0:
        print(f"warning: apksigner could not verify {apk.name}", file=sys.stderr)
        return None, None
    digest = re.search(r"certificate SHA-256 digest: ([0-9a-f]{64})", proc.stdout)
    dn = re.search(r"certificate DN: (.+)", proc.stdout)
    return (digest.group(1) if digest else None, dn.group(1).strip() if dn else None)


def apk_identity(apk: Path, aapt2: str | None) -> dict:
    if not aapt2:
        return {}
    proc = subprocess.run([aapt2, "dump", "badging", str(apk)], capture_output=True, text=True, check=False)
    if proc.returncode != 0:
        return {}
    pkg = re.search(r"^package: name='([^']+)' versionCode='([^']+)' versionName='([^']+)'", proc.stdout, re.M)
    if not pkg:
        return {}
    return {"package": pkg.group(1), "versionCode": pkg.group(2), "versionName": pkg.group(3)}


def collect(apksigner: str | None, aapt2: str | None, previous: dict):
    """Return (entries, key_changes, unverified_identities)."""
    result: dict[str, dict] = {}
    key_changes: list[tuple[str, str, str]] = []
    unverified: list[str] = []
    for apk in sorted(STATIC.glob("*/*.apk")):
        product_dir = apk.parent
        product = product_dir.name
        version = read_version(product_dir)
        digest = sha256_file(apk)
        cert, dn = signer_info(apk, apksigner)
        old = previous.get(product, {})
        if old and old.get("sha256") != digest:
            cert, dn = None, None  # never carry a fingerprint to a different file
        if cert is None and old.get("sha256") == digest:
            cert, dn = old.get("signerCertSha256"), old.get("signerDn")
        if cert is None and (not old or old.get("sha256") != digest):
            unverified.append(product)
        if cert and old.get("signerCertSha256") and cert != old["signerCertSha256"]:
            key_changes.append((product, old["signerCertSha256"], cert))

        entry = {
            "apk": apk.name,
            "version": version["version"],
            "buildNumber": version["buildNumber"],
            "bytes": apk.stat().st_size,
            "sha256": digest,
            "checksumsUrl": f"/{product}/SHA256SUMS",
        }
        if cert:
            entry["signerCertSha256"] = cert
        if dn:
            entry["signerDn"] = dn
        identity = apk_identity(apk, aapt2)
        if not identity and old.get("sha256") == digest:
            # No Android SDK here: keep what a previous run recorded for this file.
            identity = {k: old[k] for k in ("package", "versionCode", "versionName") if k in old}
        entry.update(identity)
        result[product] = entry
    return dict(sorted(result.items())), key_changes, unverified


def write(entries: dict) -> None:
    DATA.parent.mkdir(parents=True, exist_ok=True)
    DATA.write_text(json.dumps(entries, indent=2) + "\n")
    for product, entry in entries.items():
        (STATIC / product / "SHA256SUMS").write_text(f"{entry['sha256']}  {entry['apk']}\n")
    print(f"wrote {DATA.relative_to(ROOT)} and {len(entries)} SHA256SUMS file(s)")


def check(entries: dict) -> int:
    problems: list[str] = []
    if not DATA.exists():
        die(f"{DATA.relative_to(ROOT)} is missing - run scripts/apk-checksums.sh")
    committed = json.loads(DATA.read_text())

    for product, entry in entries.items():
        old = committed.get(product)
        if not old:
            problems.append(f"{product}: no entry in {DATA.name} - run scripts/apk-checksums.sh")
            continue
        for key in ("apk", "version", "buildNumber", "bytes", "sha256"):
            if old.get(key) != entry[key]:
                problems.append(f"{product}: {key} is {old.get(key)!r} in {DATA.name}, APK says {entry[key]!r}")

        sums = STATIC / product / "SHA256SUMS"
        if not sums.exists():
            problems.append(f"{product}: {sums.relative_to(ROOT)} is missing")
        elif sums.read_text().strip() != f"{entry['sha256']}  {entry['apk']}":
            problems.append(f"{product}: {sums.relative_to(ROOT)} does not match the APK")

        # version.json must agree with the APK file name
        expected = f"{product}_v{apk_filename(entry['version'])}.apk"
        if entry["apk"] != expected:
            problems.append(f"{product}: APK is named {entry['apk']!r} but version.json implies {expected!r}")

        # the page itself is rendered from templates now (see --rendered), but
        # the product data it needs must exist
        if not (ROOT / "data" / "products" / f"{product}.yaml").exists():
            problems.append(f"{product}: data/products/{product}.yaml is missing")

        # signing identity, when this run could read it
        if entry.get("signerCertSha256") and old.get("signerCertSha256") \
                and entry["signerCertSha256"] != old["signerCertSha256"]:
            problems.append(
                f"{product}: signing certificate changed - {old['signerCertSha256']} was published, "
                f"the APK is signed by {entry['signerCertSha256']}"
            )

        # APK identity, when aapt2 is available
        if entry.get("versionName") and entry["versionName"] != entry["version"]:
            problems.append(f"{product}: APK versionName {entry['versionName']!r} != version.json {entry['version']!r}")
        if entry.get("versionCode") and str(entry["versionCode"]) != str(entry["buildNumber"]):
            problems.append(f"{product}: APK versionCode {entry['versionCode']} != buildNumber {entry['buildNumber']}")

    for product in committed:
        if product not in entries:
            problems.append(f"{product}: entry in {DATA.name} but no APK in static/{product}/")

    if problems:
        print("APK integrity check FAILED:", file=sys.stderr)
        for p in problems:
            print(f"  - {p}", file=sys.stderr)
        return 1

    for product, entry in entries.items():
        print(f"ok  {product}: {entry['apk']} {entry['version']} ({entry['bytes']} bytes)")
        print(f"    sha256 {entry['sha256']}")
        if entry.get("signerCertSha256"):
            print(f"    signer {entry['signerCertSha256']}  {entry.get('signerDn', '')}")
    return 0


def check_rendered(directory: str, entries: dict) -> int:
    """Verify the built pages link the APK, show its version and its checksum."""
    root = pathlib.Path(directory)
    problems: list[str] = []
    for product, entry in entries.items():
        page = root / product / "index.html"
        if not page.exists():
            problems.append(f"{product}: {page} is missing - build the site first")
            continue
        html = page.read_text(errors="ignore")
        expectations = {
            "APK link": f'/{product}/{entry["apk"]}',
            "download label": f"Download APK {entry['version']}",
            "SHA-256": entry["sha256"],
            "SHA256SUMS link": f'{entry["checksumsUrl"]}',
        }
        for label, needle in expectations.items():
            if needle not in html:
                problems.append(f"{product}: rendered page is missing the {label} ({needle})")

    if problems:
        print("Rendered APK check FAILED:", file=sys.stderr)
        for p in problems:
            print(f"  - {p}", file=sys.stderr)
        return 1
    print(f"rendered check ok: {len(entries)} product page(s) in {directory}")
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--check", action="store_true", help="verify committed data instead of rewriting it")
    parser.add_argument("--rendered", metavar="DIR",
                        help="verify built pages in DIR (e.g. public) link the APK and show its version/checksum")
    parser.add_argument("--allow-key-change", action="store_true",
                        help="accept a new signing certificate (announce it and re-register the app first)")
    parser.add_argument("--skip-cert", action="store_true",
                        help="write without a signing certificate even though the APK changed")
    args = parser.parse_args()

    previous = json.loads(DATA.read_text()) if DATA.exists() else {}
    apksigner = find_android_tool("apksigner")
    aapt2 = find_android_tool("aapt2")
    entries, key_changes, unverified = collect(apksigner, aapt2, previous)

    if not entries:
        die("no APKs found under static/*/")

    if args.rendered:
        return check_rendered(args.rendered, entries)

    if args.check:
        return check(entries)

    if unverified and not args.skip_cert:
        die(
            "cannot verify the signing identity of a changed APK (apksigner not found):\n  "
            + "\n  ".join(unverified)
            + "\nInstall the Android build-tools or pass --skip-cert, but a published fingerprint "
              "must never be stale."
        )

    if key_changes and not args.allow_key_change:
        print("the signing certificate changed since the last release:", file=sys.stderr)
        for product, before, after in key_changes:
            print(f"  {product}: {before} -> {after}", file=sys.stderr)
        die(
            "refusing to publish a new signing identity. Existing installs cannot update in place "
            "and the fingerprint on the page is the contract with users. If this is deliberate: "
            "note the change on the landing page, register the new certificate with Android "
            "developer verification, then re-run with --allow-key-change."
        )

    if key_changes:
        for product, before, after in key_changes:
            print(f"warning: {product} signing identity changed to {after}", file=sys.stderr)

    if not apksigner and args.skip_cert:
        print("note: apksigner not found - signing-certificate fields left unchanged", file=sys.stderr)
    write(entries)
    return 0


if __name__ == "__main__":
    sys.exit(main())
