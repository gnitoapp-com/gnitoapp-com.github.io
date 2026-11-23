---
title: Categorization rules
summary: Deciding, by rule, where each imported bank transaction lands in the ledger.
layout: manual
---

A categorization rule says: when an imported transaction looks like this, post it against that account.

Rules only decide the **second line** of a bank transaction's journal — the bank's own GL account is always the first. An uncategorized transaction lands on **Suspense** instead.

**Banking ▸ Categorization Rules** lists them.

## Writing a rule

**New Rule** asks for:

- **Name** — required, so you can recognise it later.
- **Match on** — **Description** or **Amount**.
- **Description contains** — the text to look for, when the rule matches a description. It matches anywhere in the description, ignoring case.
- **Amount from** and **Amount to** — the range, when the rule matches an amount. Either end may be left open.
- **Category account** — required. Where matching transactions land.

Saving reports *"Rule created for …"*.

## Order matters

Rules have a priority, and you reorder them with **Move Up** and **Move Down**. The list is read top to bottom, the first rule that matches a transaction decides its category, and ties fall back to the older rule.

Put the specific rules above the general ones. A rule that matches everything will otherwise swallow every transaction below it.

## Applying rules

**Apply Rules** runs the rules over the transactions already in the account and reports how many it changed: *"7 transaction(s) categorized."*

Transactions that were already posted are left alone — a rule never rewrites a ledger that has already been posted.

Testing a rule costs nothing: an unposted transaction can be re-categorized as often as you like. Categorization becomes final at reconciliation.

## Learning a rule from one transaction

Categorize a single transaction by hand, and if it had no category before, Ledgerik offers to remember the correction. Accept and it creates a rule matching that transaction's description, then confirms: *"Rule created for …"*.

That is the quickest way to build a rule set: do a few by hand, and let the rules take over the repetitions.

## Editing and deleting

**Edit** changes a rule's name, match and account. **Delete** asks for confirmation, naming the rule.

Deleting a rule does not undo categories it already applied. Transactions keep the account they were given; only future applications stop.
