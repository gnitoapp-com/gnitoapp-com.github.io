---
title: Company account references
summary: The eight accounts Company Settings points at, and what changing one does.
layout: manual
---

Eight journals flows have to land somewhere specific: tax collected, tax paid, receivables, exchange differences, retained earnings, the balancing account, Suspense, and money in transit during a transfer.

Rather than hard-code accounts, Ledgerik keeps a **reference** for each and lets you choose which account it points at.

## Where They Are

**Company Settings ▸ Company Setup ▸ Accounts**. The tab lists all eight:

- **Retained Earnings**
- **Historical Balancing**
- **Exchange Gain/Loss**
- **Sales Tax Collected**
- **Sales Tax Paid**
- **Accounts Receivable**
- **Suspense**
- **Transfer Clearing** — where money in transit waits during a transfer between two bank accounts. It must be an account in the company's base currency: a cross-currency transfer posts its difference here.

A new company file arrives with sensible defaults for all eight, created with the starting chart. For most companies the defaults are right, and this tab is never touched again.

## The Tab Unlocks After Setup

The Accounts tab edits the chart of accounts that company setup creates, so it stays disabled until the **Company Information**, **Fiscal Year** and **Base Currency** tabs are saved. Opening it earlier shows nothing — a rule, not a missing configuration.

## Changing a Reference

Choose another account and save. Two consequences follow.

- **It affects future postings only.** Journals already posted stay where they were posted.
- **A balance on the old account has to be moved by hand.** If the old account still carries a balance, post an adjustment journal to move it — see [Journal Entries](/ledgerik/manual/journal-entries/).

**Restore Defaults** puts the standard mapping back, which is the quickest repair for a company whose references have drifted.

## Why a Referenced Account Cannot Be Disabled

An account pointed at by one of these eight cannot be disabled: the reference would have nowhere to post, and the failure would appear later as a broken invoice or tax line.

Ledgerik refuses, and names every reference that points at the account. Point the reference at another account first, then disable this one — see [Accounts (Chart of Accounts)](/ledgerik/manual/chart-of-accounts/).
