---
title: Period Copy
summary: A second company file holding one span of years, built from the live books.
layout: manual
---

**Company Data ▸ Period Copy** writes a company file that holds one span of years and nothing outside it. The live books are not touched: the copy is read from a fresh backup of them.

## What it asks for

- **From** and **To** — the span the copy keeps. An end date before the start date is refused.
- **Save in** — the folder, chosen with **Choose Folder**. Required.
- **File name** — required.
- **Leave attachments behind** — off by default. On, the receipts stay in the live file's folder, so the copy is smaller and shows placeholders where they would be; the receipt rows themselves still travel, because an expense points at them.

**Create Copy** writes it and reports where: *"The copy was written to …"*.

## What the copy keeps

- **Its configuration**: settings, chart of accounts, currencies, sales tax codes, bank accounts, templates and the fiscal calendar.
- **The records inside the span**: journals and their lines, invoices, estimates, payments, credit notes, expenses and receipts, mileage, time entries, bank transactions and reconciliations, and the email and reminder logs.
- **Nothing from outside the span** — with one deliberate exception, below.

**The audit log never travels.** It is a record of what happened in this installation, not part of the books, and copying it would misrepresent when things were done.

## Why the copy still balances

A span cut out of a longer history would otherwise start at zero on every account. Ledgerik avoids that in one step: it posts each account's closing balance for the day before the span into an **opening-balance journal**, described as *"Opening balances carried from the full history."*

So the copy's trial balance and balance sheet agree with the live file's, for every date inside the span. Nothing has to be re-entered and nothing has to be reconciled by hand.

A record inside the span whose parent document lies outside it — a payment against last year's invoice, a bank transaction pointing at an older journal — **brings that parent with it**. A reference from inside the copy never points at nothing.

## How you know it worked

The window reports two comparisons before it finishes, live file against copy:

- **Trial balance** for the span: live, and copy.
- **Balance sheet** at the end of the span: live, and copy.

Then either *"The copy agrees with the live file."* or the number of accounts where it differs. It also says how many receipts were copied, or how many were left behind.

Take the difference report seriously: a copy that disagrees is not a copy to archive.

## What a period copy is not

- **Not a way to shrink the live file.** It writes a new file; the books you are working in keep everything.
- **Not a backup.** A backup restores; this one is for handing a span to someone — an accountant, a buyer, a new machine — and the live file stays authoritative.
- **Not read-only.** The copy is an ordinary company file that opens, edits and posts like any other. The write-protect option was withdrawn.

Opening a period copy records nothing in the live file, and creating one records a single entry in the live **Audit Log**: the copy was exported.
