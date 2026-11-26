---
title: Time tracking
summary: Timing work, and turning recorded hours into an invoice.
layout: manual
---

**Time Tracking ▸ Time Tracker** records hours as you work and prepares them for billing.

## The timer

Type what you are working on in **What are you working on?**, choose a client, mark the entry **Billable** if you intend to charge for it, and press **Start Timer**. **Stop Timer** ends it, and the entry is saved with its duration.

One timer runs at a time.

## The two lists

**All Entries** shows everything recorded: the date, the description — or *No description* when it was left empty — and the hours.

**Unbilled** shows only the billable entries that have not been invoiced yet. If there is nothing to show it says so, and an empty tracker reads **"No time entries yet."**

## Turning hours into an invoice

Select the unbilled entries you want to bill and choose **New Invoice**. The invoice editor opens with one line per entry:

- the description as the line description,
- the hours as the quantity,
- the client, taken from the first entry you selected.

Nothing is saved until you save the invoice. Edit the lines, add the rest of the invoice, and save it as you would any other — see [Invoicing](/ledgerik/manual/invoices-and-sales/).

## Two things to know before you bill

**Time entries are recorded without a rate.** The tracker times work; it does not price it. The invoice lines therefore arrive with the hours filled in and the rate at zero, and you type the rates before saving.

**Entries are not marked as invoiced.** After you create an invoice from them, the entries remain in the Unbilled list. Check the invoices you have raised before billing the same hours twice; the tracker will not stop you.

## What time tracking does not do

- It does not set a default hourly rate, per client or per project.
- It does not invoice anything on its own, and it does not post to the books: only the invoice does that, when you finalize it.
- It does not stop a running timer when you close the window.

## Where it connects

- A time entry can name a **project**, which is how hours reach that project's budget report — see [Projects & Time](/ledgerik/manual/projects-and-time/).
- The invoice you create posts like any other: receivables, income and tax, on finalize.
