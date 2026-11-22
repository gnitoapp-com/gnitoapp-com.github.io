---
title: Getting Started
summary: Install Ledgerik, create your first company file and finish company setup.
layout: manual
menu: {manual: {weight: 10}}
---

Ledgerik keeps each company's books in its own company file on your computer. This section takes you from a first launch to a company that is ready for its first entry, so start with [Installation](/ledgerik/manual/installation/) if Ledgerik is not on your machine yet.

This manual is the application's help. Ledgerik opens it from **Help ▸ User Help**.

## First launch

With no company file open, Ledgerik shows its logo, its tagline, and two badges: the app date, or **No app date set.**, and **No open company file.**

The side menu is already there, but almost every entry is disabled. An entry becomes available only once a company file is open **and** company setup is complete. The exception is **Company Settings ▸ Company Setup**, which needs an open file and nothing else.

Two keyboard routes work from the first screen: **Ctrl+K** opens the command palette and **Ctrl+F** opens global search. **Ctrl+/** shows the shortcut reference — see [Keyboard Shortcuts](/ledgerik/manual/keyboard-shortcuts/).

## Create your first company file

1. Choose **File ▸ New**. Ledgerik asks for a file name before it asks for a folder: type the name in **Company file name** and choose **Accept**.
2. Choose the folder for the file. Ledgerik creates `<name>.acw` in it and reports that the file is now the active company file.

The name may be up to 255 characters. It cannot contain `\ / : * ? "` and it cannot be one of the reserved device names such as `CON` or `LPT1`. If a file with that name already exists in the folder, Ledgerik refuses to overwrite it and tells you so — choose another name or another folder.

Only one company file is open at a time. Opening or creating another one closes the windows of the current company first; the file on disk is untouched. See [Company Files](/ledgerik/manual/company-files/) for opening, closing and moving a file.

## Complete company setup

Until setup is finished, the home screen shows **The dashboard will be active after company setup has been completed.** Open **Company Settings ▸ Company Setup** and save all four tabs.

**Company Information** — **Company Name** is required. **Tax Number**, **Sales Tax Number**, **Address**, **Phone Number** and **Email Address** are optional, but they appear on the documents you send later. Save the tab when you are done.

**Fiscal Year** — enter the **Current Fiscal Year** as four digits and choose the **Last Month of Fiscal Year**. These decide the periods that reports and year end work with. They can be changed when you start a new fiscal year.

**Base Currency** — search for a currency and select it as the **Base Currency**. Choose deliberately: the base currency of a company cannot be changed once it is set. Saving this tab also populates the new company file with its starting chart of accounts.

**Accounts** — maps seven core references to real accounts: Retained Earnings, Historical Balancing, Exchange Gain/Loss, Sales Tax Collected, Sales Tax Paid, Accounts Receivable and Suspense. For a new company, accept the defaults. Changing a reference only affects future postings — balances already sitting on the old account have to be moved with a journal entry. **Restore defaults** puts the standard mapping back.

When the fourth tab is saved, setup is complete and the rest of the side menu becomes available.

## The home screen

The header shows the company name, the file name and the app date. Clicking the date opens **App Settings**, where the date and the date pattern are set.

With setup complete, the home screen offers quick actions — **New Invoice**, **Log Time**, **Add Expense**, **Record Payment**, **New Estimate** and **Client Portal** — a period selector (**This month**, **Last 30 days**, **Year to date**, **All time**) and **Customize dashboard**, which shows or hides the five sections: **Key numbers** (Invoiced, Paid, Outstanding, Expenses), **AR aging**, **Bank balances**, **Overdue invoices** and **Recent activity**. A hidden section stays hidden the next time you start the application.

Every data section is built from bookkeeping records, so on Ledgerik Basic the home screen shows the Basic status and the way to unlock Pro instead of the sections — see [Licensing](/ledgerik/manual/licensing/).

## Getting around

The side menu on the left is the main map: Company Settings, Accounts, Journals, Reporting, Invoicing, Projects, Client Portal, Banking, Receipts, Expenses, Time Tracking and Year End. Choosing an entry opens a window on the canvas, where windows can be moved, resized and stacked. **Windows ▸ Stack Windows** tidies them and **Windows ▸ Close All** closes them; the menus themselves are described in [Menu Bar & App Settings](/ledgerik/manual/menu-bar-and-app-settings/).

## Where to go next

- [Company Files](/ledgerik/manual/company-files/) — open, close, move and protect the file you just created.
- [Accounts (Chart of Accounts)](/ledgerik/manual/chart-of-accounts/) — the accounts behind every entry.
- [Journal Entries](/ledgerik/manual/journal-entries/) — the first real bookkeeping step.
- [Reporting](/ledgerik/manual/reports/) — what the books add up to.
