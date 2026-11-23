---
title: Other reports
summary: Cash flow, AR aging, the tax return, 1099-NEC and the audit log.
layout: manual
---

These are described in the order they appear in the Reporting group.

## Cash Flow

**Reporting ▸ Cash Flow** shows money actually moving, month by month.

It opens around today: this year, from two months back to five months ahead. Each row is a month with its **Actual In** and **Actual Out**, and the report leads with the **Opening Cash** amount and closes with the closing cash.

**Projected In** is narrower than it looks, and the report says so itself: *"Projections are invoice inflows only."* Nothing else is projected — no expenses, no payroll, no tax.

The report exports to PDF.

## AR Aging

**Reporting ▸ AR Aging** shows who owes what, and for how long.

An invoice is either **not due** yet or falls into one of four buckets: **0–30**, **31–60**, **61–90** days overdue, or **more than 90 days**.

Each row carries the client, the invoice number, its due date and the outstanding amount, with totals per bucket and per client. A **Statement** action opens that client's statement.

An invoice disappears from this report when it is paid or voided. The report exports to PDF.

## Tax Return

**Reporting ▸ Tax Return** is built from the tax codes on your postings, so it reports what the books already recorded rather than recalculating anything.

It summarizes:

- **Gross Sales**, and **Tax Collected**
- **Tax Paid** on purchases
- **Net Remittance** — what is left to remit

Then a table by **rate**, with **Gross Sales**, **Tax on Sales**, **Purchases** and **Tax on Purchases** for each rate. A rate that has never been used does not appear.

This report is not tax advice: it mirrors what was coded. If a rate was applied to the wrong line, the report repeats that mistake faithfully. It exports to PDF and CSV.

## Form 1099-NEC

**Reporting ▸ 1099-NEC** reports payments to contractors for one year.

Choose the year and a threshold. The default threshold is **600** in the base currency, and the report starts from **expenses paid to contractor-flagged vendors** — that is, vendor contacts marked **1099 Contractor** and expenses recorded against them.

For each contractor it shows the total paid, the **TIN**, and a status: reportable, below the threshold, or **missing TIN**. A contractor without a tax id cannot be filed electronically, so that column is the one to work through first.

**Run Report** builds it. Per-contractor PDFs can be generated, and the list exports to CSV.

Nothing is calculated from invoices: only expenses count, which is why a contractor paid through an invoice will not appear.

## Audit Log

**Reporting ▸ Audit Log** lists each recorded change with its entity, the action, the account it was made under, and the date and time.

What it records:

- **Contacts** — created, updated, deleted.
- **Invoices** — finalized, voided.
- **Estimates** — created, updated, emailed, converted to an invoice.
- **Payments** — recorded.
- **Credit notes** — created, deleted.
- **Expenses** — recorded, deleted, and a receipt attached or deleted.
- **Mileage** — recorded, deleted.
- **Accounts** — created, updated, disabled, re-enabled.
- **Journals** — voided.
- **Bank transfers** — recorded.
- **Bank imports** — how many transactions, into which account.
- **Reconciliations** — completed.
- **Fiscal years** — closed.
- **Company settings** — company account references changed, a currency saved, a tax code saved.

A few writes still leave no entry: creating or editing an invoice, writing a journal or an opening balance, changing a journal template, and anything in projects, company setup, recurring invoices or reminders.

**The account it was made under is the operating-system account**, taken from the environment — `USERNAME` on Windows, `USER` on macOS and Linux. Ledgerik has no logins of its own, so two people sharing one computer account are indistinguishable in the log.

Two filters narrow the list. **Entity** offers contacts, invoices, accounts, payments, expenses, settings, credit notes, journals, transfer between accounts, reconcile and import; estimates, mileage and fiscal-year entries show under the unfiltered list only. **Action** offers every action the log writes, and both filters have an all option. **Refresh** reloads the list; an empty log says **"No audit entries."**

The list is newest first and stops at **500** entries. Older ones are still in the company file; the window simply does not go further.

### How long entries are kept

Entries are deleted when a fiscal year is closed. **Year End ▸ Close Fiscal Year** advances the company's year and drops every audit entry dated before the first day of the year it just closed: close 2026 and start 2027, and entries from 2025 and earlier are gone while 2026 onwards stays.

There is no setting for it and no size limit. That prune is what keeps the log — and every backup of the company file, which carries the log with it — from growing without end.

Nothing in this window changes anything.

## Where to go next

- The three statements are on [Financial statements](/ledgerik/manual/reports/financial-statements/).
- The project report is with projects, in [Projects & Time](/ledgerik/manual/projects-and-time/).
- What the reports read is described in [Reporting](/ledgerik/manual/reports/).
