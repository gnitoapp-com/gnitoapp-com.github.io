---
title: Other reports
summary: Cash flow, AR aging, the tax return and 1099-NEC.
layout: manual
---

These four are described in the order they appear in the Reporting group.

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

**Reporting ▸ Tax Return** is built from the sales tax codes on your postings, so it reports what the books already recorded rather than recalculating anything.

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

**Reporting ▸ Audit Log** is a different kind of report: it lists what changed rather than what the books say. It has its own page — [Audit Log](/ledgerik/manual/reports/audit-log/).

## Where to go next

- The three statements are on [Financial statements](/ledgerik/manual/reports/financial-statements/).
- The project report is with projects, in [Projects & Time](/ledgerik/manual/projects-and-time/).
- What the reports read is described in [Reporting](/ledgerik/manual/reports/).
