---
title: Backups, Import & Restore
summary: The snapshots Ledgerik takes, the encrypted copy you carry, restoring either, and importing CSV data.
layout: manual
menu: {manual: {weight: 120}}
---

Three things live in **Company Settings**: **Backups**, which takes and restores copies of the company file; the encrypted export, which carries the file *and* its receipts to another machine; and **Import Data**, which brings CSV rows in.

## Automatic snapshots

Ledgerik snapshots the company file by itself, at three moments:

- **when a company file opens**;
- **every 15 minutes** while it is open;
- **once more when the file is closed**.

Each snapshot is a full copy of the company file, written with SQLite's own consistent-copy operation, so a snapshot is never half-written. They live in the application's support folder, one folder per machine, not beside the company file.

The window says so itself: *"Automatic snapshots run when a company file opens, every 15 minutes while it is open, and when it closes. Retention keeps 7 daily + 4 weekly snapshots."*

## How many are kept

Retention is by age, not by count:

- the newest snapshot of each of the **last 7 days**;
- the newest of each ISO week for the **four weeks before** that window;
- plus anything dated after now, which only clock changes produce.

Older snapshots are removed as new ones arrive. A day of heavy work therefore leaves one snapshot for that day, not dozens.

## Taking one by hand, and restoring

**Backup Now** takes a snapshot immediately. A backup cannot be taken with no company file open — the window says **"Open a company file before creating a backup."**

Restoring offers two different operations, and they are not interchangeable:

- **Replace the open company file** — takes a safety snapshot of what is open now, closes it, copies the snapshot over it, and reopens. Ledgerik reports *"Company file restored from backup."* The safety snapshot is why a restore that goes wrong can still be undone.
- **Restore as a new file** — writes the snapshot to a path you choose and opens it, leaving the current company alone. Ledgerik reports *"Restored file opened."*

Before either, the snapshot is validated exactly like a company file opened from disk: readable SQLite, a schema version this build understands, its tables present, and nothing but tables and indexes inside — see [Company Files](/ledgerik/manual/company-files/).

**Delete** asks first and removes a snapshot for good.

## The encrypted export and import

**Export Encrypted** writes one `.acwz` file containing the company file **and every receipt attachment**, encrypted with a passphrase.

Two things about that passphrase:

- **It cannot be recovered.** The window says it in as many words, on export and on import. Lose it and the file is unreadable, by anyone.
- **It must be at least 12 characters**, and the two entries must match.

This is the copy to move a company to another machine, or to another operating system: the container is a plain byte format with no platform in it, and the database inside is portable SQLite. **Import Encrypted** restores it — writing the receipts back into the company's receipts folder — and reports *"Company file restored with attachments."*

Snapshots are not portable in the same sense: they hold the company file only, no receipts.

## Import Data

**Import Data** reads a CSV file into one of four things: the **Chart of Accounts**, **Contacts**, **Invoices** or **Journal Entries**.

Pick what you are importing, then **Choose CSV File**. The window names the columns it expects — **Expected columns: …** — before you commit, then shows a preview with its row count.

Running it reports three numbers: **Imported**, **Skipped** and **Errors**, with a line per bad row: *Row 12: …*. Nothing is silently dropped.

Two things worth knowing: imported invoices arrive as **drafts**, so they still need finalizing to post; and imported journals are created as entries, which means they are immutable from the moment they land.

## Where the copies actually are

Snapshots live in the application's support folder. The encrypted export and the automatic snapshots both belong to the machine you are on — neither is synced anywhere, and no copy leaves the computer unless you move it. [Company Files](/ledgerik/manual/company-files/) explains why the company file itself is the thing worth protecting.

Backups, restoring and the encrypted **import** are free on every plan. Only two things here are **Pro**: the encrypted **export**, and the CSV **import** — see [Licensing](/ledgerik/manual/licensing/).
