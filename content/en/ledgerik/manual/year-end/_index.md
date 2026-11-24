---
title: Year End
summary: Closing a fiscal year — what is posted, what is locked, and what cannot be undone.
layout: manual
menu: {manual: {weight: 110}}
---

A fiscal year ends once, and closing it is the one operation in Ledgerik that cannot be reversed. **Year End ▸ Close Fiscal Year** is the whole section.

## The fiscal year

The year is set in **Company Setup ▸ Financial Year**: the **Current Fiscal Year** as four digits, and the **Last Month of Fiscal Year**. The periods of the year are created from them, one per month.

**A fiscal year is not always twelve months.** It starts the day after the previous year ends, so there is never a gap between years, and its length follows the last month:

- the **same** last month as the year before gives a twelve-month year;
- a **later** last month gives a **longer** year — the months it gained, plus the twelve that follow;
- an **earlier** last month gives a **shorter** year — just the months between the old end and the new one.

There is no maximum length, so a company that changes its year end once can carry a longer year through and settle on twelve months afterwards.

## What closing does

The window lists four consequences before you commit, in its own words:

- the current fiscal year is **closed and locked** for further entries;
- all **income and expense account balances are zeroed out**;
- the net income or loss is calculated and **transferred to Retained Earnings**;
- a **new fiscal year is opened** automatically for the next period.

Its note is the one to take seriously: *"Ensure all journal entries for the current year have been posted before proceeding."* Closing does not wait for anyone, and it takes the balances as it finds them.

**Confirm and Close** asks once: *"Are you sure you want to close the current fiscal year? This process will generate year-end journals and cannot be reversed."* Then it reports *"The 2026 fiscal year has been closed."*

## Choosing where the new year ends

The same window also carries **Last Month of the New Fiscal Year**, with the hint *"The new fiscal year ends in this month. Choose an earlier month to open a shorter year."*

It starts at the company's current last month, so closing without touching it behaves exactly as before. Change it to end the new year earlier or later; the year you are closing is unaffected either way.

If the new month differs from the one in company settings, the periods already generated for the new year *and the year after it* are re-cut, because periods are derived from the setting rather than typed. A year that is already closed cannot be re-cut, and Ledgerik refuses rather than let the settings and the months disagree.

## What is posted

One closing journal, dated at the end of the year, in the base currency. It carries each income and expense account's closing balance to zero, and the net result to the account Company Settings maps to **Retained Earnings** — see [Company account references](/ledgerik/manual/chart-of-accounts/company-account-references/).

The journal is an ordinary entry: it appears in **Journal Entries** with the rest, and it is what makes the year's profit and loss statements start each new year at zero.

A year that already carries a closing journal is not closed twice — the second attempt is a no-op rather than a second posting, so retrying after a failure cannot double the profit.

## What happens afterwards

- **The year is locked.** Any posting, void or opening-balance save dated inside it is refused: *"This date … belongs to a closed fiscal period."* That covers invoices, payments, expenses, mileage, transfers, reconciliations and hand-written journals alike.
- **Opening balances lock too.** The window reports **Opening Balances Locked** from then on — see [Opening balances](/ledgerik/manual/chart-of-accounts/opening-balances/).
- **Older audit entries are pruned.** Entries dated before the first day of the year you just closed are deleted, so the log keeps the closed year onwards — see [Audit Log](/ledgerik/manual/reports/audit-log/).
- **Nothing reopens it.** There is no unlock and no reopen anywhere in the application. A correction after closing is an entry in the new year, not an edit to the old one.

## Before you close

Four things, in this order:

1. **Post everything.** A draft is invisible to the closing journal.
2. **Reconcile the bank accounts** — see [Banking](/ledgerik/manual/banking/).
3. **Back up**, and take the encrypted export if you want the receipts with it — see [Backups, Import & Restore](/ledgerik/manual/backups/).
4. **Export the statements you will want to show someone** — see [Reporting](/ledgerik/manual/reports/). The reports still run after closing; the exports are for the people who ask for a file.

## What closing does not do

- It deletes nothing. Every invoice, expense, journal and receipt stays where it was, and every report for the closed year still runs.
- It does not archive the year or move it out of the file.
- It does not close part of a year. One close, one year.
