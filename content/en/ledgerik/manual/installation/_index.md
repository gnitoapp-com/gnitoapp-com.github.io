---
title: Installation
summary: Install Ledgerik on Windows, macOS or Linux.
layout: manual
menu: {manual: {weight: 5}}
---

Ledgerik is a desktop application. It runs from a folder of its own and does not install a service, a driver or anything else system-wide — and it never puts your books in that folder.

## What you need

Windows 10 or 11 (64-bit), macOS, or 64-bit Linux.

## Getting the build

Builds are published on the [Ledgerik page](/ledgerik/), and only there: there is no store, no package repository and no auto-update. If a platform's build has not been published yet, its entry on that page reads **Coming soon**.

Each download is an archive of the complete application. Unpack the whole archive rather than a single file out of it, because the application expects the files beside it.

## Windows

1. Download the `.zip` archive from the [Ledgerik page](/ledgerik/).
2. Extract all of it into a folder you can write to, for example `C:\Users\<you>\Ledgerik`.
3. Start `ledgerik.exe` from that folder.

If Windows warns about the publisher, continue only if the archive came from the Ledgerik page.

## macOS

1. Download the `.zip` archive from the [Ledgerik page](/ledgerik/). It contains `ledgerik.app`.
2. Move `ledgerik.app` to **Applications**, or anywhere else you like to keep applications.
3. Open it.

The build is signed ad hoc rather than notarized for distribution, so the first launch may be refused. Open the app once from the Finder context menu (**Open**) to allow it, or allow it under **System Settings ▸ Privacy & Security**.

## Linux

1. Download the `.tar.gz` archive from the [Ledgerik page](/ledgerik/).
2. Extract it: `tar -xzf ledgerik-<version>-linux-x64.tar.gz`.
3. Start the `ledgerik` executable from inside the extracted folder.

If the executable was extracted without its execute permission, restore it with `chmod +x ledgerik`.

## Where your data lives

The folder you extracted holds the program, nothing else. Your books live in `.acw` company files that you create yourself and can put wherever you want — see [Company Files](/ledgerik/manual/company-files/). Replacing or deleting the application folder never touches them.

Preferences belong to the installation rather than to a company file: the date pattern, the language and the dashboard sections you have hidden are kept separately, and the menu bar's **File ▸ App Settings** is where the first two are changed.

## Upgrading

Unpack the new build and replace the application folder with it. Keep your company files where they are: there is no migration step, and Ledgerik does not update itself.

## Removing Ledgerik

Delete the application folder. Your company files remain wherever you created them, so back them up first if you are removing Ledgerik for good — see [Backups, Import & Restore](/ledgerik/manual/backups/).
