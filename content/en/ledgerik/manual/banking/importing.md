---
title: Importing bank transactions
summary: Bringing a statement into a bank account, from an OFX/QFX file or pasted CSV.
layout: manual
---

Imported transactions are the raw material of banking. They do not touch the ledger: nothing is journaled until you reconcile — see [Banking](/ledgerik/manual/banking/).

Open the bank account you are importing into. The import offers two routes.

## From an OFX or QFX file

**Import OFX/QFX…** opens a file picker, then a preview before anything is written: **OFX/QFX import preview**.

The preview lists what was found — *"12 transactions found"* — and states the rule: *"Importing into the selected bank account. Duplicate transactions are skipped automatically."*

Confirm, and Ledgerik reports what it did: *"12 imported, 0 skipped (duplicates)."*

## From a pasted statement

If your bank gave you a spreadsheet rather than a file, copy the rows and paste them into the import box. The box says what it expects: **"Paste CSV data (date, description, amount):"** — three columns in that order, one transaction per line.

The result is reported the same way, with one addition. A row Ledgerik could not read is not silently dropped: *"3 row(s) could not be read and were skipped."*

## What "duplicate" means

Ledgerik compares each incoming transaction with the ones already in that account. A transaction that matches an existing one is skipped rather than added twice.

This is what makes re-importing safe. Import the same statement twice and the second run reports the transactions as skipped instead of doubling your balance. It is also why the preview tells you the count before you commit.

## After importing

New transactions are **uncategorized**, and they carry no journal entry. Two things are still to do:

1. categorize them — by hand, or with [Categorization rules](/ledgerik/manual/banking/categorization-rules/);
2. reconcile the account, which is what posts them — see [Banking](/ledgerik/manual/banking/).

## What importing does not do

- It does not change the account's balance history: the balance is the opening balance plus what is recorded, and imports add to it.
- It does not post anything. An import that fails and is retried cannot double the books, because nothing was posted in the first place.
- It does not guess the category. Categorization is a separate, deliberate step.
