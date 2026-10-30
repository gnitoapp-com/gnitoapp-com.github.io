---
title: Support
description: Where can I get additional support?
linkTitle: Support
menu: {main: {weight: 50}}
weight: 100
---

If you have any questions, feedback, bug reports, or improvement suggestions, please contact us at:

**Email: support@gnitoapp.com**

We want to hear from you!

## Verifying a download

Every product page shows a "Verify this APK" block with the SHA-256 of the
current APK, the SHA-256 of the certificate it was signed with, and a link to the
`SHA256SUMS` file next to the download.

Android has no built-in checksum tool, so pick whichever of these fits:

**On the phone (where most of you download):** install
[Termux](https://f-droid.org/packages/com.termux/) and run

```bash
termux-setup-storage            # once, grants access to Downloads
sha256sum ~/storage/downloads/units2units_v1_2_0.apk
```

If `sha256sum` is missing, `pkg install coreutils` first. A reputable
checksum/hash app from your app store works too.

**On a computer:** download the file there (or copy it over) and run

```bash
sha256sum units2units_v1_2_0.apk     # Linux, macOS
Get-FileHash units2units_v1_2_0.apk  # Windows PowerShell
```

The value must match the one on the product page exactly. If it does not, delete
the file and email us — a mismatched hash means the download is not the build we
published.

The certificate fingerprint is the other value in that block. It identifies the
key the build was signed with and is checked with `apksigner verify --print-certs`
(part of the Android SDK build-tools), so treat it as a check on a computer; the
file hash is the one to check on the phone.

Android may warn that the app was not installed from an app store; that is
expected for direct downloads. Verify the hash and certificate first, then choose
"Install Anyway" only if both match.

## Signing-key changes

If an app's signing key ever has to change, the new build cannot update an
existing install in place: Android rejects the signature mismatch. We will say so
in a notice at the top of that product page, with the new certificate
fingerprint, and installing it requires uninstalling the old version once. Your
data in the old app is removed by that uninstall, so export anything you need
first.