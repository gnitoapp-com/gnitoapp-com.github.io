---
title: Accounts (Chart of Accounts)
summary: The accounts behind every entry — how they are classed, added, disabled and balanced.
layout: manual
menu: {manual: {weight: 30}}
---

Every entry in Ledgerik ends up on an account. The chart of accounts is the full list of them.

## Folders and Posting Accounts

Each account has one role, chosen when you create it.

- **Folder** — groups other accounts. It never takes a journal line. It exists to keep the list readable.
- **Posting Account** — takes the journal lines. Every amount in the books lands on one of these.

The form asks for a folder when you create a posting account. That is what the folder is for.

## Class and Type

A posting account has two more labels.

**Class** is the broad group. Ledgerik has eight, numbered 1 to 8: **Asset**, **Liability**, **Equity**, **Income**, **Cost of Sales**, **Expense**, **Other Income** and **Other Expense**.

The class decides three things: where the account appears in the statements, whether it normally carries a debit or a credit balance, and whether it may hold a foreign currency. Asset, Liability and Equity may; the income and expense classes may not.

**Type** is the finer label inside a class. There are sixteen, from **Bank** and **Accounts Receivable** through **Fixed Asset**, **Credit Card**, **Long Term Liability** and **Other Expense**.

Choose the class first: the type list then offers only the types that belong to it. A Bank account is an Asset; a Credit Card is a Liability.

## Adding an Account

Open **Accounts ▸ List Accounts** and choose **New**. The form asks for:

- **Account Role** — required. Choose **Folder** or **Posting Account**.
- **Account Classification** — required for a posting account. The class.
- **Account Type** — required for a posting account. The types of the chosen class only.
- **Folder** — required for a posting account. The folder it belongs in.
- **Account Name** — required.
- **Sequence Number** — required, and a positive number. It sets the account's order inside its folder.
- **Currency** — shown only when the class may hold a foreign currency, and then required.
- **Tax Return Code** — optional, up to 100 characters: your own classification for a filing form. It is stored with the account and read by no report; it is not a sales tax rate — see [Company Settings](/ledgerik/manual/settings/).
- **Disabled** — a switch that marks the account inactive. Every posting account has one.

Only **Currency** depends on the class: it is offered for **Asset**, **Liability** and **Equity**, never for the income and expense classes, which keep the base currency. The tax return code and the disabled switch appear on every posting account.

A folder needs only its name and its sequence number.

## Editing an Account

Open an account from the list to edit it. The same fields are there, including the **Disabled** switch. An existing account's **Currency** is shown but cannot be changed, which is why it is chosen at creation.

Change the name or the sequence number freely. Changing the class or the type moves the account in the reports, so do it deliberately.

**An account can only be disabled while its balance is zero.** If the account carries a balance, the switch stays greyed out, and the form says why: *"A disabled account must have a zero balance and cannot accept new transactions."* Move the balance off the account first — a journal entry moves it, it is never deleted. A disabled account can always be enabled again.

**An account that Company Settings uses cannot be disabled either.** If one of its eight references points at this account, the switch greys out and the form names the reference: *"This account is used by Company Settings as {references} and cannot be disabled. Point that reference at another account first."*

An account that is already disabled can still be edited and re-enabled, whatever points at it.

## The Accounts List

The list shows the accounts as a tree; folders expand and collapse.

Each row carries the account's name, its class and type, and its balance in the account's own currency — with the base-currency figure underneath when the two differ. A disabled account carries a **Disabled** badge.

Two controls sit above the list. **Hide disabled accounts?** filters them out. **Export CSV** writes the list to a file: Name, Sequence, Role, Class, Type, Currency, Native Balance and Base Balance.

## There Is No Delete

Ledgerik does not delete accounts. You disable them instead.

A disabled account accepts no new transactions. Its history stays: the journals that used it are untouched, and the trial balance still lists it.

Two reports leave it out. The **Balance Sheet** and the **Income Statement** list only enabled accounts, so a disabled account disappears from both.

That is why disabling requires a zero balance: a balance left behind would vanish from those two statements while still sitting in the journal. Move the balance first, then disable the account.

An account created by mistake is disabled the same way.

## Opening Balances

**Accounts ▸ Opening Balances** records where each account stood when you started keeping books. The window must balance before it will save, and it locks once a year is closed. See [Opening balances](/ledgerik/manual/chart-of-accounts/opening-balances/).

## Where Accounts Come From

A new company file arrives with a starting chart, created when you save the **Base Currency** tab during setup. Company Settings then points eight references at real accounts — receivables, tax, exchange differences, Suspense and others. See [Company account references](/ledgerik/manual/chart-of-accounts/company-account-references/).
