---
title: Expenses, Receipts & Mileage
summary: Spending recorded against the books, the files that prove it, and journeys claimed as expenses.
layout: manual
menu: {manual: {weight: 70}}
---

Three menu entries record money going out: **Expenses ▸ Expenses**, **Expenses ▸ Mileage Log**, and **Receipts ▸ Receipt Gallery**. A fourth, **Receipts ▸ Receipt Storage**, looks after the files those receipts are made of.

This page covers recording an expense. The others have their own pages, linked below.

## Recording an Expense

In the **Expenses** window, **New Expense** opens the form.

- **Date** — required.
- **Merchant** — required. Who was paid.
- **Account** — required. The expense account the spend belongs to.
- **Paid From** — required. The account the money left: a bank account, a credit card, cash.
- **Amount** — required, greater than zero, and recorded with tax included.
- **Sales Tax Code** — optional. The tax rate is taken from it.
- **Currency**, and **Rate to {currency}** when it is not the base currency.
- **Client** and **Project** — optional, if the spend belongs to one.
- **Billable** and **Markup** — see below.
- **Notes**
- **Receipt** — **Attach…** adds a photo, a scan or a PDF. See [Receipts](/ledgerik/manual/expenses-and-receipts/receipts/).

Saving posts a bill to the general journal: the expense account is debited and the **Paid From** account is credited, both for the amount including tax. The sales tax code decides the tax line, exactly as on an invoice.

## Billable and Markup

**Billable** marks the expense as one you intend to charge a client for. **Markup** is the percentage you intend to add.

Both are recorded on the expense, and both are shown in the list. Neither one acts on its own: nothing in Ledgerik puts a billable expense onto an invoice today, and no markup is applied anywhere. Treat them as notes on the expense, not as a billing step.

## The Expense List

Each row shows the date, the merchant, the account and the amount. **Attach** opens the receipts for that expense, and the row's delete action removes it.

Deleting an expense asks first, naming the merchant, and then voids the journal entry the expense posted. **An expense with a receipt attached cannot be deleted until the receipt is** — the receipt points at the expense, and Ledgerik refuses rather than leaving it orphaned. Delete the receipt from the expense first, then the expense. The books are corrected rather than trimmed, so an expense that was already reported on is still visible in the journal as a voided entry — see [Journal Entries](/ledgerik/manual/journal-entries/).

## Mileage

**Expenses ▸ Mileage Log** records journeys claimed as expenses, with their own journal posting. See [Mileage](/ledgerik/manual/expenses-and-receipts/mileage/).

## What Expenses Affect

- **The general journal** — a bill per expense, voided if you delete it.
- **The income statement** — the expense account you chose.
- **The tax return report** — through the sales tax code.
- **The home screen** — the expenses figure, and recent activity.
- **The reports** — every statement in [Reporting](/ledgerik/manual/reports/).

Every entry here is Ledgerik **Pro** — see [Licensing](/ledgerik/manual/licensing/).
