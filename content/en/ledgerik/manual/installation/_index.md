---
title: Installation
summary: Install Ledgerik on Windows, macOS or Linux, from this website or from a store.
layout: manual
menu: {manual: {weight: 5}}
---

Ledgerik is a desktop application for Windows, macOS and Linux. Every release is downloadable from this website for all three systems, and is also published in the store each platform provides. Use whichever route you prefer — the application is the same, and your books are never stored inside it.

## What you need

Windows 10 or 11 (64-bit), macOS, or 64-bit Linux.

## Windows

**From this website.** Download the `.msi` from the [Ledgerik page](/ledgerik/) and run it. When it finishes, start Ledgerik from the Start menu or the shortcut it created. To remove it later, use **Settings ▸ Apps**.

**From the Microsoft Store.** Open the Microsoft Store, search for Ledgerik and install it from there. The Store handles later updates for you.

## macOS

**From this website.** Download the `.dmg` from the [Ledgerik page](/ledgerik/), open it, and drag `ledgerik.app` into **Applications**. Then open it from **Applications** like any other Mac application.

**From the Mac App Store.** Search for Ledgerik in the App Store and install it from there. Updates arrive through the App Store.

## Linux

**From this website.** Download the Linux package from the [Ledgerik page](/ledgerik/) and install it with your distribution's package tool.

**Snap.** Install the `ledgerik` snap:

```bash
sudo snap install ledgerik
```

**Flatpak.** Install Ledgerik from your Flatpak source, in the same way as any other Flatpak application.

## Where your data lives

The application holds the program and nothing else. Your books live in `.acw` company files that you create yourself, wherever you choose to keep them — see [Company Files](/ledgerik/manual/company-files/). Installing, upgrading or removing Ledgerik never touches them.

Preferences belong to the installation rather than to a company file: the date pattern, the language and the dashboard sections you have hidden are kept separately, and **File ▸ App Settings** is where the first two are changed.

## Upgrading

Install the newer version the way you installed the first one — the installer, the `.dmg`, the Linux package or the store's update — and it replaces the previous version. Your company files stay exactly where they are: there is no migration step, and Ledgerik only updates itself through a store.

## Removing Ledgerik

Uninstall it the way you installed it: **Settings ▸ Apps** on Windows, by moving `ledgerik.app` from **Applications** to the Bin on macOS, with `snap remove ledgerik` or your Flatpak tool on Linux, or with the package tool for the Linux package.

Your company files remain wherever you created them, so back them up first if you are removing Ledgerik for good — see [Backups, Import & Restore](/ledgerik/manual/backups/).
