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

## Verify an Android Download

Every product page shows a "Verify this APK" block. It gives the SHA-256 of the current APK. It also gives the SHA-256 of the certificate the APK was signed with, and a link to the `SHA256SUMS` file next to the download.

Android has no built-in checksum tool, so pick whichever of these fits.

**On the phone:** install [Termux](https://f-droid.org/packages/com.termux/) and run

```bash
termux-setup-storage            # once, grants access to Downloads
sha256sum ~/storage/downloads/units2units_v1_3_0.apk
```

If `sha256sum` is missing, run `pkg install coreutils` first. A reputable checksum app from your app store works too.

**On a computer:** download the file there, or copy it over, and run

```bash
sha256sum units2units_v1_3_0.apk     # Linux, macOS
Get-FileHash units2units_v1_3_0.apk  # Windows PowerShell
```

The value must match the one on the product page exactly. If it does not, delete the file and email us. A mismatched hash means the download is not the build we published.

The certificate fingerprint is the other value in that block. It identifies the key the build was signed with. Check it with `apksigner verify --print-certs`, which is part of the Android SDK build-tools. Treat that as a check on a computer. On the phone, check the file hash.

Android may warn that the app was not installed from an app store. That is expected for direct downloads. Verify the hash and the certificate first. Choose "Install Anyway" only if both match.

## Signing-Key Changes

If an app's signing key ever has to change, the new build cannot update an existing install in place. Android rejects the signature mismatch. We will say so in a notice at the top of that product page, with the new certificate fingerprint. Installing the new build requires uninstalling the old version once. Your data in the old app is removed by that uninstall, so export anything you need first.
