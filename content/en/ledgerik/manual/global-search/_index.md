---
title: Global Search
summary: One box that finds a contact, an invoice, an account or a journal.
layout: manual
menu: {manual: {weight: 160}}
---

**Global Search** opens a window with one search field. Type part of a name, a number or a description and it lists what matches.

There is no keyboard shortcut: it is a window, opened from the side menu like any other.

## What It Searches

Four kinds of record:

- **contacts**
- **invoices**
- **accounts**
- **journals**

The field's own hint says the same: *"Search contacts, invoices, accounts and journals"*.

A search returns at most **eight results per kind**, so a broad word stays readable rather than filling the window. Results are grouped under those four headings, in that order.

Before you type anything it says **"Type to search your records."**; a term with nothing behind it says **"No matches."**

## Reading a Result

Each row shows the record's name and a line of detail, so two similar hits can be told apart before you open either:

- a **contact** shows its email and tax id, when it has them;
- an **invoice** shows its issue date and its status;
- an **account** shows its class and type — only enabled accounts are offered;
- a **journal** shows its effective date and its type.

## What a Result Does

Choosing a result opens that record, not its list:

- a **contact** or an **account** opens its edit window;
- an **invoice** opens the invoice editor with that invoice loaded;
- a **journal** opens in the read-only journal view.

That is the point of the window: it is the shortest route from remembering a name to editing the record behind it.

## Pro or Basic

The window itself is part of **Ledgerik Basic**, so you can always open it. What it looks through depends on the plan:

- **Ledgerik Basic** — it searches **accounts and journals** only. Contacts and invoices are Pro records, so a Basic installation does not search them at all.
- **Ledgerik Pro** — all four kinds are searched: contacts, invoices, accounts and journals.

While the licence is still being checked, Ledgerik treats the plan as Basic, so nothing paid-for appears before the licence is known. If a refund takes a licence back to Basic with the window already open, the contacts and invoices results drop out and the accounts and journals results stay.

The rule is simple: searching a record needs the same licence as opening it — see [Licensing](/ledgerik/manual/licensing/).

## What Global Search Does Not Do

- **It changes nothing.** Searching opens records; it never edits, posts or voids.
- **It is not a report.** No totals, no date ranges, no export.
- **It searches four kinds of record, not the whole application.** Projects, estimates, expenses and mileage are not searched — reach those from their lists.
- **It does not hide voided records.** A voided invoice is still found, and its status in the row says so.
