---
title: Company Files
summary: How a company is stored, opened, closed and moved — and what Ledgerik checks before it opens one.
layout: manual
menu: {manual: {weight: 20}}
---

Every company Ledgerik keeps is one file on your disk. That file is the entire book — accounts, journals, invoices, expenses and settings — and nothing else is needed to open it somewhere else.

## One file, one company

A company file ends in `.acw` and holds a SQLite database. It sits in whatever folder you chose when you created it; Ledgerik does not copy it anywhere else, and nothing is written into the application's own folder.

Two consequences worth knowing before you move anything:

- **The file is portable.** Copy it to another disk or another computer, and Ledgerik opens it there with every entry intact.
- **The file is the only copy.** There is no server, no sync and no hidden store; if it is deleted, the books are gone unless you have a backup. [Backups, Import & Restore](/ledgerik/manual/backups/) is the next section to read.

## Creating a file

**File ▸ New** asks for a name, then for a folder, and creates `<name>.acw` in it. If a file with that name is already in that folder, Ledgerik refuses rather than overwriting it. [Getting Started](/ledgerik/manual/getting-started/) walks through the two steps and the naming rules.

## Opening a file

**File ▸ Open** shows a file picker titled **Open company file**, filtered to `.acw`. Choose the file and Ledgerik loads it, including the company name in the window header.

If the picker is cancelled, nothing changes. If the file cannot be opened, Ledgerik says why in one sentence:

- **Company file does not exist** — the path is no longer valid, usually because the file was moved or deleted.
- **The file … is not a valid company file** — the file exists but cannot be trusted as a Ledgerik company file (see below).

## What "not a valid company file" means

A company file can arrive from a colleague, a backup, a synced folder or an untrusted source, so Ledgerik checks it before handing it to the rest of the application. The check runs read-only and the file is refused unless all of this holds:

- it is readable SQLite;
- its schema version is one this build knows — an older or newer version than this application understands is refused rather than half-opened;
- it carries the tables every company file has;
- it contains no schema objects Ledgerik never writes itself. Ledgerik creates only tables and indexes, so a stored trigger or view is treated as foreign code and the file is refused.

The point is not suspicion of your own files — it is that opening a company file runs its contents through the application, and an unreadable or unexpected file should fail cleanly instead of half-way.

## Closing a file

**File ▸ Close** closes every open window and releases the company. The file on disk is not touched: closing is not a save, because entries are written as you make them, and it is not a delete.

Ledgerik does not remember which company you had open. After a restart it starts with no company, and you open the file again — there is no recent-files list on purpose, so the application never opens a company you did not ask for.

## One company at a time

Only one company file is open at a time. To work on another, close the current one and open the other; Ledgerik closes the open windows first, so nothing is left pointing at the previous company.

Keeping two copies of the same file and opening them on two machines creates two books that drift apart — the copies do not know about each other. If you need the same company in two places, decide which copy is authoritative and restore from a backup rather than merging by hand.

## Moving, copying and renaming

- **Close Ledgerik before moving or renaming a file.** The application keeps the file open while a company is loaded.
- Copying the file is safe while it is closed; the copy is an independent company from the moment it exists.
- Renaming is fine too, as long as you reopen the renamed file — nothing inside the file stores its own name.
- A file restored from a backup, or received from someone else, opens through **File ▸ Open** like any other.
