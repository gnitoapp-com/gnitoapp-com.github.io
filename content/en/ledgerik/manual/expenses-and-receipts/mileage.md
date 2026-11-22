---
title: Mileage
summary: Journeys claimed as expenses, priced per unit of distance.
layout: manual
---

**Expenses ▸ Mileage Log** records travel you claim as a business expense. Each entry is a journey, and each journey posts to the books like any other expense.

## Logging a journey

**Log Mileage** asks for:

- **Date**
- **Start Odometer** and **End Odometer** — the reading before and after the journey. The end reading must be higher than the start.
- **Purpose** — required. What the journey was for.
- **Rate per Unit** — required, and greater than zero. The amount each unit of distance is worth.
- **Billable**, with a **Client** — optional. Only meaningful when the journey is chargeable.
- **Expense Account** — required. The account the expense lands on.
- **Paid From** — required. The account that would otherwise have paid for the travel.

The amount is the distance multiplied by the rate. Ledgerik then posts a bill to the general journal: the expense account is debited and the **Paid From** account is credited.

If the posting fails, the mileage entry is rolled back with it, so a journey is never left logged without its journal entry.

## The mileage list

Each row shows the date, the purpose, the distance and the amount. **Delete** asks first, naming the journey, and then voids the journal entry the mileage posted — the same correction an expense gets, for the same reason.

## Billable mileage

**Billable** and **Client** are recorded on the entry so you can tell which journeys are chargeable.

They do not put anything on an invoice by themselves. Nothing in Ledgerik turns a billable journey into an invoice line today, so the flags are notes on the entry rather than a billing step — the same as **Billable** on an expense, described in [Expenses, Receipts & Mileage](/ledgerik/manual/expenses-and-receipts/).

## Where it appears

Mileage entries are expenses, so they reach the income statement through the account you chose, and the tax return report through the tax code on that account's entries. The reports themselves are described in [Reporting](/ledgerik/manual/reports/).
