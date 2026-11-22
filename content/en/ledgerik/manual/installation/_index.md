---
title: Installation
summary: Install Ledgerik on Windows, macOS or Linux, from this website or from a store.
layout: manual
menu: {manual: {weight: 5}}
---

Ledgerik is a desktop application. It is always downloadable from this website, for every platform, and it is also published through the stores each platform has. It runs from its own folder and does not install a service, a driver or anything else system-wide — and it never puts your books in that folder.

## What you need

Windows 10 or 11 (64-bit), macOS, or 64-bit Linux.

## Windows

**From this website.** Download the `.msi` from the [Ledgerik page](/ledgerik/) and run it. After it finishes, start Ledgerik from the Start menu. To remove it later, use **Settings ▸ Apps**.

**From the Microsoft Store.** Search for Ledgerik in the Microsoft Store and install it from there; the Store handles the installation and later updates.

## macOS

**From this website.** Download the `.dmg` from the [Ledgerik page](/ledgerik/), open it and drag `ledgerik.app` into **Applications**, then open it.

The website build is signed ad hoc rather than notarized for distribution, so the first launch may be refused. Open the app once from the Finder context menu (**Open**) to allow it, or allow it under **System Settings ▸ Privacy & Security**.

**From the Mac App Store.** Search for Ledgerik in the App Store and install it from there; there is no Gatekeeper step, because the App Store build is already approved.

## Linux

**From this website.** Download the Linux package from the [Ledgerik page](/ledgerik/) and install it with the package tool your distribution uses.

**Snap.** Install the `ledgerik` snap:

```bash
sudo snap install ledgerik
```

**Flatpak.** Install Ledgerik from your Flatpak source, in the same way as any other Flatpak application.

## Where your data lives

The application holds the program, nothing else. Your books live in `.acw` company files that you create yourself and can put wherever you want — see [Company Files](/ledgerik/manual/company-files/). Installing, upgrading or removing the application never touches them.

Preferences belong to the installation rather than to a company file: the date pattern, the language and the dashboard sections you have hidden are kept separately, and the menu bar's **File ▸ App Settings** is where the first two are changed.

## Upgrading

Install the newer version the same way you installed the first one — the installer, the `.dmg`, or the store's update — and it replaces the older application. Your company files stay where they are: there is no migration step, and Ledgerik does not update itself outside the store channels.

## Removing Ledgerik

Uninstall Ledgerik the way you installed it: **Settings ▸ Apps** on Windows, by deleting it from **Applications** on macOS, or with your package tool on Linux. If you installed from an archive, deleting the folder is enough.

Your company files remain wherever you created them, so back them up first if you are removing Ledgerik for good — see [Backups, Import & Restore](/ledgerik/manual/backups/).
