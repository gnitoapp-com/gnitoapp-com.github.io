---
title: Recurring invoices
summary: A series that issues the same invoice on a schedule.
layout: manual
---

A recurring series produces invoices for you on a schedule. **Invoicing ▸ Recurring Invoices** lists the series. Nothing generates on its own: a series produces invoices only when you press one of the two generate actions below.

## Creating a Series

**New Recurring Series** asks for:

- **Client** — required.
- **Currency**, and a **Rate to Base Currency** when it is not the base currency.
- **Line items** — the lines every generated invoice will carry.
- **Schedule** — `Every` a number, then the unit: **days**, **weeks**, **months**, **quarters** or **years**.
- **First Run Date** — when the first invoice is due to be generated.

When the series is created Ledgerik reports *"Recurring invoice series created."*

## Statuses

- **Active** — the series generates invoices on its schedule.
- **Paused** — it generates nothing until you resume it.
- **Cancelled** — finished.

## Generating Invoices

Two actions generate on demand.

- **Generate Now** — issues the next invoice immediately, whatever the schedule says.
- **Generate Due** — issues every invoice whose scheduled date has arrived, which is what you want after a gap.

Each run reports what it did: *"3 invoices generated, 3 finalized and posted."* If something failed, the same message adds the error below it, so a partly successful run is never silent.

Generated invoices are ordinary invoices. They appear in **Invoices** with their own numbers, and can be edited, voided and emailed like any other — see [Invoicing](/ledgerik/manual/invoices-and-sales/).

## Pausing and Resuming

**Pause** stops a series without deleting its settings. **Resume** starts it again from the current schedule. Neither action touches invoices that were already generated.

## What a Series Does Not Do

A series is a schedule, not a document. It holds no status the books care about, creates no journal entries by itself, and produces nothing until an invoice is generated from it.
