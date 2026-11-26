---
title: Journal Entries
summary: The entry you write yourself — lines, balance, voiding, and what can never be edited.
layout: manual
menu: {manual: {weight: 40}}
---

A journal entry is one dated entry with two or more lines. Its debits and credits must come to zero before Ledgerik will save it.

Every other part of the application posts journal entries: an invoice, a payment, an expense, a mileage claim, opening balances, year-end closing. This section is about the ones you write by hand.

## Writing an entry

**Journals ▸ New Journal Entry** opens the form.

**Type** — one of **General Journal**, **Money Transfer**, **Expense**, **Income**, **Investment**, **Redemption**, **Payment**, **Credit Note** and **Adjustment**. The type labels the entry in the list; it does not change how the lines post.

**Effective Date** — the date the entry belongs to. Ledgerik refuses a date in a closed fiscal period: *"This date 2026-01-31 belongs to a closed fiscal period."* A date with no fiscal period at all is refused too: *"Fiscal period not found for the selected date."*

**Currency** and **Rate to {currency}** — for an entry in a currency other than the base one.

**Lines** — **Add Line** for each one. A line carries:

- **Account** — required, and only accounts that can take a posting are offered.
- **Debit** and **Credit** — put the amount on one side of the line.
- **Memo** — optional, and it travels with the line.
- **Sales Tax** — optional. Where it applies, *"always enter the inclusive amount"*: type the gross figure and Ledgerik splits out the tax.

**Total Balance** sits under the lines and must read zero. It is coloured green when it does, and **Save** stays disabled until it does.

**Save as a template** stores the entry's lines for reuse — see [Journal templates](/ledgerik/manual/journal-entries/journal-templates/).

## The journals list

**Journals ▸ Journals** shows every entry, newest first, with its date, its type and its description. An entry that has been reversed carries a **Voided** badge, and the reversal itself carries **Voiding**.

Three filters narrow the list: **Filter by Account** (with a search box and an all-accounts option), **From Date** and **To Date**.

## Opening an entry

**View** opens the entry in full: its lines, their accounts, their memos and the amounts.

A reversed entry links to its reversal, and the reversal links back, so the two halves are never separated. From that window, **export to PDF** writes the entry out as a document.

## Voiding

Corrections are made by voiding, never by editing. **Void** asks first: *"Are you sure you want to void this journal? This action will create a reversing entry and cannot be undone."*

Then it asks for **Select Reversal Effective Date** — the date the reversing entry takes. Cancel that prompt and nothing happens: *"Action cancelled, the journal has not been voided."*

Two rules follow from what a void is.

- **An entry can be voided once.** A second attempt is refused: *"This journal is already voided."*
- **A reversal cannot be voided.** Voiding it would quietly restore the entry you corrected, so Ledgerik refuses: *"A voiding entry cannot itself be voided."*

When the void succeeds, both entries stay in the list with their badges, and the books show the correction.

A reversal is priced like any other movement, so voiding a foreign-currency entry produces a realized exchange gain or loss rather than restoring the original base amount — see [Currencies](/ledgerik/manual/currencies/).

## Templates

Reusable sets of lines live under **Journals ▸ Journal Templates**; they are described in [Journal templates](/ledgerik/manual/journal-entries/journal-templates/).

## What never happens to a journal

A posted entry is never edited and never deleted. Its lines, its date and its amounts stay as they were posted. That is what makes the books auditable: a mistake is corrected by a reversal on a date of your choosing, and both halves remain visible.

Every entry here is free on Ledgerik Basic — journals are part of the general ledger, not of the paid features. See [Licensing](/ledgerik/manual/licensing/).
