---
title: Getting Started
summary: Create your first company file and finish company setup.
layout: manual
menu: {manual: {weight: 10}}
---

Ledgerik keeps each company's books in its own company file on your computer.

This section takes you from a first launch to a company ready for its first entry. Start with [Installation](/ledgerik/manual/installation/) if Ledgerik is not on your machine yet.

This manual is the application's help. Ledgerik opens it from **Help ▸ User Help**.

## First launch

With no company file open, Ledgerik shows its logo and its tagline. Two badges follow. The first shows the app date, or **No app date set.** when none is set. The second reads **No open company file.**

The side menu is already there. Almost every entry is disabled.

An entry becomes available only when a company file is open and company setup is complete. The exception is **Company Settings ▸ Company Setup**. It needs an open file and nothing else.

Two keyboard routes work from the first screen. **Ctrl+K** opens the command palette. **Ctrl+F** opens global search. **Ctrl+/** shows the shortcut reference — see [Keyboard Shortcuts](/ledgerik/manual/keyboard-shortcuts/).

## Create your first company file

1. Choose **File ▸ New**. Ledgerik asks for a file name first. Type it in **Company file name** and choose **Accept**.
2. Choose the folder for the file. Ledgerik creates `<name>.acw` in it. It then reports that the file is now the active company file.

The name may be up to 255 characters. It cannot contain `\ / : * ? "`. It cannot be a reserved device name such as `CON` or `LPT1`.

If a file with that name already exists in the folder, Ledgerik refuses to overwrite it. It tells you so. Choose another name or another folder.

Only one company file is open at a time. Opening or creating another one closes the windows of the current company first. The file on disk is untouched. See [Company Files](/ledgerik/manual/company-files/).

## Complete company setup

Until setup is finished, the home screen shows **The dashboard will be active after company setup has been completed.**

Open **Company Settings ▸ Company Setup**. Save all four tabs.

**Company Information** — **Company Name** is required. **Tax Number**, **Sales Tax Number**, **Address**, **Phone Number** and **Email Address** are optional. They appear on the documents you send later. Save the tab when you are done.

**Fiscal Year** — enter the **Current Fiscal Year** as four digits. Choose the **Last Month of Fiscal Year**. These decide the periods that reports and year end work with. You can change them when you start a new fiscal year.

**Base Currency** — search for a currency and select it. Choose deliberately. The base currency of a company cannot be changed once it is set. Saving this tab also fills the new company file with its starting chart of accounts.

**Accounts** — maps seven core references to real accounts: Retained Earnings, Historical Balancing, Exchange Gain/Loss, Sales Tax Collected, Sales Tax Paid, Accounts Receivable and Suspense. For a new company, accept the defaults.

Changing a reference affects future postings only. Balances already sitting on the old account have to be moved with a journal entry. **Restore defaults** puts the standard mapping back.

When the fourth tab is saved, setup is complete. The rest of the side menu becomes available.

## The home screen

The header shows the company name, the file name and the app date. Clicking the date opens **App Settings**, where the date and the date pattern are set.

With setup complete, the home screen offers six quick actions. They are **New Invoice**, **Log Time**, **Add Expense**, **Record Payment**, **New Estimate** and **Client Portal**.

A period selector offers **This month**, **Last 30 days**, **Year to date** and **All time**.

**Customize dashboard** shows or hides five sections:

- **Key numbers** — invoiced, paid, outstanding and expenses.
- **AR aging**
- **Bank balances**
- **Overdue invoices**
- **Recent activity**

A hidden section stays hidden the next time you start the application.

Every data section is built from bookkeeping records. On Ledgerik Basic, the home screen shows the Basic status and the way to unlock Pro instead. See [Licensing](/ledgerik/manual/licensing/).

## Getting around

The side menu on the left is the main map. Its groups are Company Settings, Accounts, Journals, Reporting, Invoicing, Projects, Client Portal, Banking, Receipts, Expenses, Time Tracking and Year End.

Choosing an entry opens a window on the canvas. Windows can be moved, resized and stacked. **Windows ▸ Stack Windows** tidies them. **Windows ▸ Close All** closes them. The menus themselves are described in [Menu Bar & App Settings](/ledgerik/manual/menu-bar-and-app-settings/).

## Where to go next

- [Company Files](/ledgerik/manual/company-files/) — open, close, move and protect the file you just created.
- [Accounts (Chart of Accounts)](/ledgerik/manual/chart-of-accounts/) — the accounts behind every entry.
- [Journal Entries](/ledgerik/manual/journal-entries/) — the first real bookkeeping step.
- [Reporting](/ledgerik/manual/reports/) — what the books add up to.
