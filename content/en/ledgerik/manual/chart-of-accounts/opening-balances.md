---
title: Opening balances
summary: Where each account starts — entered once, and locked once a year is closed.
layout: manual
---

An opening balance is where an account stood when you started keeping its books in Ledgerik. **Accounts ▸ Opening Balances** opens **Record opening balances**.

## What the window shows

Every posting account, in alphabetical order, except **Historical Balancing**. Folders are not listed: they hold nothing themselves.

Type each account's starting amount and save. Ledgerik records the result as one opening balance journal, which is why the entries appear in [Journal Entries](/ledgerik/manual/journal-entries/) with the rest.

## The balance must reach zero

A running total in the base currency sits under the list and shows how far you are from balanced.

**Save stays disabled until that total is exactly zero.** There is no "save what you have" — an opening balance book that does not balance cannot be posted, which is the whole point of entering it this way.

If the figure will not come out to zero, something is missing from a pair. A bank account without the equity or loan that funded it, or an asset without its depreciation so far, are the usual causes.

## Entering it more than once

Saving again does not quietly overwrite the first attempt. Ledgerik voids the previous opening balance journal — a reversal, not a deletion — and posts the new figures, so you can revisit them as the opening day approaches and the books still show what changed.

## Once a year is closed, it locks

After a year-end closing journal exists, the window shows **Opening Balances Locked** and explains why: *"Opening balances cannot be entered or modified because a year-end closing journal already exists."*

From then on, corrections go through ordinary journals — Ledgerik says so itself: *"Please use general journals to make any required changes to account totals."* See [Journal Entries](/ledgerik/manual/journal-entries/).

That is deliberate. Once a closing entry has carried balances forward, the starting point of the books is history, and history is corrected by adjustment, not by rewriting.

## Opening balances are not the only way in

A company that starts trading on day one may leave the opening balance at zero and let the first transactions set the scene. Opening balances exist for the case where the business did not start when Ledgerik did.
