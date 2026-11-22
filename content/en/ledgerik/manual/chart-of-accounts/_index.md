---
title: Accounts (Chart of Accounts)
summary: The accounts behind every entry — how they are classed, added, disabled and balanced.
layout: manual
menu: {manual: {weight: 30}}
---

Every entry in Ledgerik ends up on an account. The chart of accounts is the full list of them.

## Folders and posting accounts

Each account has one role, chosen when you create it.

- **Folder** — groups other accounts. It never takes a journal line. It exists to keep the list readable.
- **Posting Account** — takes the journal lines. Every amount in the books lands on one of these.

A posting account always sits inside a folder. That is what the folder is for.

## Class and type

A posting account has two more labels.

**Class** is the broad group. Ledgerik has eight, numbered 1 to 8: **Asset**, **Liability**, **Equity**, **Income**, **Cost of Sales**, **Expense**, **Other Income** and **Other Expense**.

The class decides three things: where the account appears in the statements, whether it normally carries a debit or a credit balance, and whether it may hold a currency other than the company's base currency. Asset, Liability and Equity may. The income and expense classes may not.

**Type** is the finer label inside a class. There are sixteen, from **Bank** and **Accounts Receivable** through **Fixed Asset**, **Credit Card**, **Long Term Liability** and **Other Expense**.

Choose the class first. The type list then offers only the types that belong to it. A Bank account, for example, is an Asset, and Credit Card is a Liability.

## Adding an account

Open **Accounts ▸ List Accounts** and choose **New**. The form asks for:

- **Account Role** — required. Choose **Folder** or **Posting Account**.
- **Account Classification** — required for a posting account. The class.
- **Account Type** — required for a posting account. The types of the chosen class only.
- **Folder** — required for a posting account. The folder it belongs in.
- **Account Name** — required.
- **Sequence Number** — required, and a positive number. It sets the account's order inside its folder.
- **Currency** — shown only when the chosen class allows a foreign currency. It is then required.
- **Tax Return Code** — optional, up to 100 characters.
- **Disabled** — a switch for posting accounts. A disabled account cannot accept new transactions.

A folder needs only its name and its sequence number.

## Editing an account

Open an account from the list to edit it. The same fields are there, including the **Disabled** switch.

Change the name or the sequence number freely. Changing the class or the type moves the account in the reports, so do it deliberately.

## The accounts list

The list shows the accounts as a tree. Folders expand and collapse, so you can read the chart the way it is organised.

Each row carries the account's name, its class and its type. It shows the balance in the account's own currency. When that currency differs from the company's base currency, the base-currency figure is shown underneath it.

Two controls sit above the list. **Hide disabled accounts?** filters them out. **Export CSV** writes the list to a file, with the columns Name, Sequence, Role, Class, Type, Currency, Native Balance and Base Balance.

A disabled account keeps a badge in the list, so it is never invisible by accident.

## There is no delete

Ledgerik does not delete accounts. You disable them instead.

A disabled account accepts no new transactions. It keeps its history, it keeps its balances, and the reports still count it. That is the point: a chart of accounts is part of the audit trail, and a used account cannot simply disappear.

If an account was created by mistake and has never been used, disabling it is still the way to go. It then stays out of the way without breaking anything that refers to it.

## Opening balances

**Accounts ▸ Enter Opening Balances** opens **Record opening balances**.

The window lists every posting account, in alphabetical order, except the **Historical Balancing** account. Type each account's starting amount, then save.

Two rules apply.

- **The balance must reach zero.** A running total in the base currency shows how far you are from that. **Save** stays disabled until the total is zero.
- **Once a year is closed, the window locks.** It then reads **Opening Balances Locked**, and explains that a year-end closing journal already exists. Changes after that go through general journals — see [Journal Entries](/ledgerik/manual/journal-entries/).

## Where accounts come from

A new company file arrives with a starting chart, created when you save the **Base Currency** tab during setup. The **Accounts** tab of company setup then maps seven core references to real accounts: Retained Earnings, Historical Balancing, Exchange Gain/Loss, Sales Tax Collected, Sales Tax Paid, Accounts Receivable and Suspense.

Changing a reference affects future postings only. Balances already on the old account must be moved with a journal entry. [Getting Started](/ledgerik/manual/getting-started/) covers that tab, and [Company Settings](/ledgerik/manual/settings/) covers the rest of the company's own settings.
