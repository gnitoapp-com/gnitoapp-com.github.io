---
title: Audit Log
summary: What changed, who changed it, and how long the record is kept.
layout: manual
---

**Reporting ▸ Audit Log** lists each change a user makes: the entity, the action, the operating-system account it ran under, and the date and time.

## What it records

- **Documents** — invoices created, updated, finalized, voided; estimates created, updated, emailed, converted, deleted; credit notes created and deleted; payments recorded.
- **Bookkeeping** — hand-written journals and journal voids; journal templates; opening balances.
- **Expenses and mileage** — expenses created and deleted, receipts attached and deleted; mileage recorded and deleted.
- **Contacts and accounts** — created, updated, deleted; accounts also disabled and re-enabled.
- **Banking** — transfers, imports, reconciliations, categorization rules.
- **Projects and time** — projects created, completed, held and deleted; time entries, with timer start and stop.
- **Recurring and reminders** — series created, paused, resumed, cancelled; invoices generated; reminder settings and reminder sends.
- **Configuration** — company settings, company account references, currencies and sales tax codes (saved and deleted), the mail account, the Stripe keys.
- **Data** — encrypted exports and imports.

**Only hand-written journals are logged.** The entries Ledgerik posts for an invoice, a payment or a reconciliation are visible through those documents, so the log is not filled with automatic noise. Fiscal-period generation and the year-end closing journal record nothing themselves; the year close records once, as a closed fiscal year.

## What the window can show

**Entity** offers eighteen options — contacts, invoices, accounts, payments, expenses, settings, credit notes, journals, journal templates, transfer between accounts, reconcile, import, backup, projects, time entries, recurring invoices, reminders and categorization rules. **Estimates, mileage and fiscal years have no filter option yet**, so those entries appear only in the unfiltered list.

**Action** covers every action written: created, updated, deleted, finalized, voided, reconciled, attached, disabled, re-enabled, imported and exported. Both filters have an all option; **Refresh** reloads the list, and an empty log says **"No audit entries."**

**The account is the operating-system account** — `USERNAME` on Windows, `USER` on macOS and Linux — because Ledgerik has no logins of its own; two people sharing a computer account look identical here.

The list is newest first and stops at **500** entries; older ones stay in the file.

## How long entries are kept

Entries are deleted when a fiscal year is closed. **Year End ▸ Close Fiscal Year** advances the company's year and drops every audit entry dated before the first day of the year it just closed: close 2026 and start 2027, and entries from 2025 and earlier are gone while 2026 onwards stays.

There is no setting for it and no size limit. That prune is what keeps the log — and every backup of the company file, which carries the log with it — from growing without end.

Nothing in this window changes anything.

## Where to go next

- The reports themselves are on [Other reports](/ledgerik/manual/reports/other-reports/) and [Financial statements](/ledgerik/manual/reports/financial-statements/).
- What a report reads is described in [Reporting](/ledgerik/manual/reports/).
