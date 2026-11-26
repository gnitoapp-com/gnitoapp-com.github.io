---
title: Installation
summary: Install Ledgerik on Windows, macOS or Linux, from this website or from a store.
layout: manual
menu: {manual: {weight: 5}}
---

Ledgerik is a desktop application. It runs on Windows, macOS and Linux. Every release is downloadable from this website. Each platform's store carries it too.

Use whichever route you prefer. It is the same application either way. Your books are never stored inside it.

## What you need

Windows 10 or 11, 64-bit. macOS. 64-bit Linux.

## Windows

**From this website.** Download the `.msi` from the [Ledgerik page](/ledgerik/). Run it. Start Ledgerik from the Start menu, or from the shortcut the installer created. To remove it, use **Settings ▸ Apps**.

**From the Microsoft Store.** Open the Microsoft Store. Search for Ledgerik. Install it from there. The Store handles later updates.

## macOS

**From this website.** Download the `.dmg` from the [Ledgerik page](/ledgerik/). Open it. Drag `ledgerik.app` into **Applications**. Open it from there, like any other Mac application.

**From the Mac App Store.** Search for Ledgerik in the App Store. Install it from there. Updates arrive through the App Store.

## Linux

**From this website.** Download the `.AppImage` from the [Ledgerik page](/ledgerik/). Make it executable. Run it.

```bash
chmod +x ledgerik-<version>-x86_64.AppImage
./ledgerik-<version>-x86_64.AppImage
```

An AppImage is the whole application in one file. It does not install itself. It needs no administrator rights. It adds no entry to your applications menu. It runs from wherever you keep it.

AppImages use FUSE 2. Most distributions provide it. Some recent ones do not, including Fedora 43 and later.

If Ledgerik does not start, and the terminal says **AppImages require FUSE to run**, install the compatibility package:

- **Debian, Ubuntu** — `sudo apt install libfuse2`. On Ubuntu 24.04 and later the package is `libfuse2t64`.
- **Fedora, RHEL** — `sudo dnf install fuse fuse-libs`
- **openSUSE** — `sudo zypper install fuse libfuse2`
- **Arch** — `sudo pacman -S fuse2`

If you cannot install anything, start the file with `--appimage-extract-and-run` instead. It unpacks the application to a temporary folder. It needs no FUSE and no administrator rights.

**From the Snap Store.** Install the `ledgerik` snap:

```bash
sudo snap install ledgerik
```

The snap updates itself. The AppImage does not. Come back to the [Ledgerik page](/ledgerik/) when you want a newer AppImage.

## Where your data lives

The application holds the program. Nothing else.

Your books live in `.acw` company files. You create them, and you choose where to keep them. See [Company Files](/ledgerik/manual/company-files/). Installing, upgrading or removing Ledgerik never touches them.

Preferences belong to the installation, not to a company file. The date pattern, the language and the dashboard sections you have hidden are kept separately. **File ▸ App Settings** is where the first two are changed — see [Menu Bar & App Settings](/ledgerik/manual/menu-bar-and-app-settings/).

## Upgrading

Install the newer version the way you installed the first one:

- **Windows** — run the newer `.msi`. It replaces the installed version.
- **macOS** — open the newer `.dmg`. Replace `ledgerik.app` in **Applications**.
- **Linux, AppImage** — download the newer file. Delete the old one.
- **Linux, snap** — `sudo snap refresh ledgerik`, or wait for the snap to refresh itself.

If you installed from a store, the store delivers the update. Your company files are untouched in every case. There is no migration step.

## Removing Ledgerik

Uninstall it the way you installed it:

- **Windows** — **Settings ▸ Apps**, then uninstall Ledgerik.
- **macOS** — move `ledgerik.app` from **Applications** to the Bin.
- **Linux, AppImage** — delete the `.AppImage` file.
- **Linux, snap** — `sudo snap remove ledgerik`.

Uninstalling removes the application only. Your company files stay where you created them. Back them up first if you are removing Ledgerik for good — see [Company Data](/ledgerik/manual/company-data/).
