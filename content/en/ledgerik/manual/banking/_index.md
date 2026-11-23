---
title: Banking
summary: Bank accounts, the transactions in them, and the reconciliation that posts them to the ledger.
layout: manual
menu: {manual: {weight: 80}}
---

Banking records what happened at the bank. It does **not** post anything to the ledger until you reconcile — that is the single most important thing to know about this group.

Two entries are here: **Banking ▸ Bank Accounts** and **Banking ▸ Categorization Rules**.

## Bank accounts

**Bank Accounts ▸ Add Account** asks for:

- **Account Name** — required.
- **Currency** — required.
- **Opening Balance** and **Opening Balance Date** — where the account stood when you started tracking it.
- **Linked GL Account** — required. The account in the chart of accounts that this bank account posts to. If the chart has no bank account yet, create one first; the window says so.

Each bank account shows its **balance**, computed as the opening balance plus every transaction recorded against it.

## Transactions

Open a bank account to see its transactions. Each row carries a date, a description and an amount, and a marker showing whether the transaction has been **categorized** or is still **uncategorized**.

Transactions arrive by import — from an OFX or QFX file, or pasted from a statement. See [Importing bank transactions](/ledgerik/manual/banking/importing/).

Once they are in, you categorize them by hand or with a rule — see [Categorization rules](/ledgerik/manual/banking/categorization-rules/).

An empty account says **"No transactions yet. Import a CSV to get started."**

## Reconciliation

Reconciliation is where banking becomes bookkeeping. It takes the transactions you have imported and posted and turns them into journal entries.

The window asks for a **Statement Balance**, then **Complete Reconciliation**. It shows its own reminder as you work: *"Statement balance: … as of … — compare with the account balance before reconciling."* Three things then happen.

1. **The balance must match.** Ledgerik compares the statement balance with the opening balance plus every transaction in the account. If they differ, it refuses and reports both figures. A reconciliation is a proof, not a formality.
2. **Each unposted transaction is journaled.** The bank's linked GL account is debited or credited for the amount, and the other side goes to the account the transaction was **categorized** to. An uncategorized transaction goes to **Suspense**, which is exactly the account that exists to hold things you have not sorted out yet.
3. **The reconciliation completes**, and the transactions carry their journals from then on.

Posting happens once per transaction. A transaction that already has a journal is not posted again, so a second reconciliation cannot double the books.

If a bank account has no linked GL account, reconciliation refuses and asks you to link one first.

## Categorizing before you reconcile

Categorization decides the second line of the journal: the category account instead of Suspense. Do it before reconciling — the transaction's own amount, date and description never change, only where the other side lands.

## Where payments live

Money received against an invoice is recorded under **Invoicing ▸ Record Payment**, not here — see [Payments and credit notes](/ledgerik/manual/invoices-and-sales/payments-and-credit-notes/).

The Banking group contains exactly two entries: **Bank Accounts** and **Categorization Rules**. There are no transfers and no bank feeds in this build.

Every window here is Ledgerik **Pro** — see [Licensing](/ledgerik/manual/licensing/).
