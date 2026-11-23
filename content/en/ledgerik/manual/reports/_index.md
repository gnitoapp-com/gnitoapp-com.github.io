---
title: Reporting
summary: The eight reports, where each one lives, and what they read.
layout: manual
menu: {manual: {weight: 100}}
---

Ledgerik has eight reports. **Three** are under **Reporting**. **Five** are under **Company Settings** — which is where readers lose them.

## Where each report is

| Report | Menu |
| --- | --- |
| Trial Balance | Reporting ▸ Trial Balance |
| Balance Sheet | Reporting ▸ Balance Sheet |
| Income Statement | Reporting ▸ Income Statement |
| AR Aging | Company Settings ▸ AR Aging |
| Tax Return | Company Settings ▸ Tax Return |
| Cash Flow | Company Settings ▸ Cash Flow |
| Budget vs. Actual | Company Settings ▸ Budget vs. Actual |
| 1099-NEC | Company Settings ▸ 1099-NEC |

The three statements have their own page — [Financial statements](/ledgerik/manual/reports/financial-statements/). The other four live here: [Other reports](/ledgerik/manual/reports/other-reports/). **Budget vs. Actual** is described with projects, in [Projects & Time](/ledgerik/manual/projects-and-time/).

## What every report reads

All of them read the **posted journals**, and nothing else. A report is a view of the ledger, not of the documents you have written.

That has one consequence worth remembering: **a draft invoice is in no report.** It appears once it is finalized and its journal entry is posted, and it disappears when the invoice is voided. The same is true of an expense you have not saved.

## Controls they share

- **A date range or an as-of date.** The statements take From Date and To Date; the Balance Sheet takes an as-of date; the cash flow report works in months.
- **An account filter**, where a report needs one — the Trial Balance has **Filter by Account** with a search box and an all-accounts option.
- **Export to PDF.** Most reports have it, and it is offered only once the data has finished loading: *"Please wait for data to load before generating PDF."*
- **Close**, which closes the window without changing anything.

Two reports also export CSV: the tax return and the 1099-NEC.

## Reading a number you do not believe

When a figure looks wrong, check these four things in this order:

1. **The period.** A closed fiscal period refuses new postings, and a date outside the range is simply not counted.
2. **Whether the document was finalized.** A draft invoice or an unsaved expense is invisible to every report.
3. **The currency.** Reports total in the base currency, converting foreign amounts at the rate stored on each posting — see [Currencies](/ledgerik/manual/currencies/).
4. **Whether the account is disabled.** The Balance Sheet and the Income Statement list enabled accounts only, so a disabled account leaves both — see [Accounts (Chart of Accounts)](/ledgerik/manual/chart-of-accounts/).

## What reporting does not do

- There is no report builder and no custom report.
- There is no consolidation across companies: one company file, one set of reports.
- Nothing in this group posts, voids or changes an entry. Reports read.
