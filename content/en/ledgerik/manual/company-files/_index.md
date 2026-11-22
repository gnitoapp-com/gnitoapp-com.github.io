---
title: Company Files
summary: How a company is stored, opened, closed and moved — and what Ledgerik checks before it opens one.
layout: manual
menu: {manual: {weight: 20}}
---

Every company Ledgerik keeps is one file on your disk. That file is the entire book: accounts, journals, invoices, expenses and settings. Nothing else is needed to open it somewhere else.

## One file, one company

A company file ends in `.acw`. It holds a SQLite database.

The file sits in the folder you chose when you created it. Ledgerik does not copy it anywhere else. Nothing is written into the application's own folder.

Two things follow from that.

- **The file is portable.** Copy it to another disk or another computer. Ledgerik opens it there with every entry intact.
- **The file is the only copy.** There is no server, no sync and no hidden store. If you delete it, the books are gone unless you have a backup. Read [Backups, Import & Restore](/ledgerik/manual/backups/) next.

## Creating a file

**File ▸ New** asks for a name, then for a folder. It creates `<name>.acw` in that folder.

If a file with that name is already there, Ledgerik refuses. It does not overwrite.

[Getting Started](/ledgerik/manual/getting-started/) walks through both steps and the naming rules.

## Opening a file

**File ▸ Open** shows a file picker titled **Open company file**. The picker is filtered to `.acw`. Choose the file and Ledgerik loads it. The company name then appears in the window header.

If you cancel the picker, nothing changes.

If the file cannot be opened, Ledgerik says why in one sentence.

- **Company file does not exist** — the path is no longer valid. The file was probably moved or deleted.
- **The file … is not a valid company file** — the file exists, but it cannot be trusted as a Ledgerik company file. The next section explains the checks.

## What "not a valid company file" means

A company file can arrive from a colleague. It can come from a backup, a synced folder or anywhere else. So Ledgerik checks it before the rest of the application sees it.

The check reads the file and does not modify it. The file must pass four tests.

- It must be a readable SQLite database.
- Its schema version must be one this build can handle. A file written by a **newer** version of Ledgerik is refused. A file written by an **older** version is accepted, and the application upgrades it when it opens.
- It must contain the tables every company file carries.
- It must contain nothing except tables and indexes. Ledgerik writes only tables and indexes. A stored trigger, view or virtual table runs its own SQL inside the application. So the file is refused.

Two things follow from the second test.

- **Opening an older file changes it.** The upgrade rewrites the schema. Back the file up before you open it, if it came from elsewhere.
- **Do not open a company file with an older Ledgerik.** A newer file is refused, and downgrading the application does not help.

The point of all this is not suspicion of your own files. It is that opening a company file runs its contents through the application. An unreadable or unexpected file should fail cleanly, not half-way.

## Closing a file

**File ▸ Close** closes every open window. It releases the company.

The file on disk is not touched. Closing is not a save: entries are written as you make them. It is not a delete either.

Ledgerik does not remember which company you had open. After a restart it starts with no company. You open the file again.

There is no recent-files list, on purpose. The application never opens a company you did not ask for.

## One company at a time

Only one company file is open at a time. To work on another, close the current one and open the other. Ledgerik closes the open windows first, so nothing is left pointing at the previous company.

Do not keep two copies of the same file and open them on two machines. That makes two books. They drift apart, because the copies do not know about each other.

If you need the same company in two places, decide which copy is authoritative. Restore from a backup instead of merging by hand.

## Moving, copying and renaming

- **Close Ledgerik first.** The application keeps the file open while a company is loaded.
- **Copying is safe while the file is closed.** The copy is an independent company from the moment it exists.
- **Renaming is fine.** Reopen the renamed file afterwards. Nothing inside the file stores its own name.
- **A restored or received file** opens through **File ▸ Open** like any other.
