---
title: Financial statements
summary: Trial balance, balance sheet and income statement — the first three in the Reporting group.
layout: manual
---

These three read the ledger directly and answer three different questions. All of them are free on Ledgerik Basic.

## Trial Balance

**Reporting ▸ Trial Balance** proves that the books balance. It lists accounts with their debits, their credits and the resulting balance, plus an **Opening Balance** line, and totals the columns at the foot.

Three controls:

- **From Date** and **To Date** — the period the entries are taken from.
- **Filter by Account** — narrow the list, with a search box and an all-accounts option.

**The trial balance drills down.** Choose **Open** on a row and the journal entry behind that balance opens. That is the fastest route from a figure you do not believe to the posting that produced it — see [Journal Entries](/ledgerik/manual/journal-entries/).

The totals at the bottom must agree. If they do not, something is wrong at a level no report can fix, and the next place to look is an unbalanced opening balance — see [Opening balances](/ledgerik/manual/chart-of-accounts/opening-balances/).

## Balance Sheet

**Reporting ▸ Balance Sheet** is a photograph of the company at one moment: what it owns, what it owes, and what is left for the owners.

Choose an **as-of date** and the report shows **Assets**, **Liabilities** and **Equity**, with a total for each and a **Total Liabilities and Equity** to compare with Total Assets.

Two things follow from when it is taken. It has no From Date, because a balance sheet never does — it is a position, not a period. And it lists enabled accounts only, so a disabled account is absent from it — see [Accounts (Chart of Accounts)](/ledgerik/manual/chart-of-accounts/).

## Income Statement

**Reporting ▸ Income Statement** covers a period instead of a moment, which is why it takes **From Date** and **To Date**.

It reads top to bottom in the order the accounts are classed:

- **Income**
- **Cost of Sales**, then **Gross Profit**
- **Expenses**
- **Other Income** and its net
- **Operating Income**, then **Net Income**

Each block has its own total, and the subtotals follow from them: gross profit is income less cost of sales, and net income is what is left after expenses and other items.

## Which One Answers What

- *Did the books balance in this period?* — Trial Balance.
- *What is the company worth on this date?* — Balance Sheet.
- *Did the company make money over this period?* — Income Statement.

## Exports

Each of the three exports to PDF, from the report window, once its data has loaded. Nothing else about the report changes with the export: the same period, the same figures.
