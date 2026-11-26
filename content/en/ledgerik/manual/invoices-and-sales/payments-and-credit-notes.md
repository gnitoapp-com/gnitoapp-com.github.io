---
title: Payments and credit notes
summary: Recording money received against an invoice, and reducing what a client owes.
layout: manual
---

Two entries in the Invoicing group move money that has already been invoiced: **Record Payment** brings money in, and **Credit Notes** take part of a charge away.

## Recording a Payment

**Invoicing ▸ Record Payment** opens the payments window.

The form asks for:

- **Invoice** — required. Choose the invoice the money is against.
- **Payment Date** — required.
- **Method** — required: **Cash**, **Check**, **Credit Card**, **ACH Transfer**, **Wire Transfer** or **Other**.
- **Amount** — required, and greater than zero.
- **Deposit To** — required. The account the money lands in.
- **Reference Number** — optional, for a cheque number or a transfer reference.
- **Rate to {currency}** — appears when the invoice is in a foreign currency.

Saving posts a journal entry: the deposit account is debited and the company's account for receivables is credited, both for the amount received. The payment's own rate is used for the base amounts, and the difference against the invoice's rate is handled as described in [Currencies](/ledgerik/manual/currencies/).

Three rules are enforced.

- **A zero or negative amount is refused.** It would silently increase the client's outstanding balance instead of settling it.
- **A voided invoice cannot be paid.**
- **Overpayment is refused.** A payment that would take the total paid past the invoice's total is not accepted. Several payments up to the total are fine.

The invoice becomes **Paid** when the payments cover its total. Partial payments leave it as it was.

Payments are listed in the same window, with the invoice, the date, the method and the amount.

## Credit Notes

A credit note reduces what a client owes, without changing the original invoice. **Invoicing ▸ Credit Notes** lists them.

**New Credit Note** asks for:

- **Invoice** — required. The invoice being reduced.
- **Reason** — required.
- **Amount** — required, and greater than zero.

**Issue Credit Note** posts it. Ledgerik reports *"Credit note issued and posted to the general journal."* From then on it counts against the invoice and appears on the client's statement.

Deleting a credit note asks for confirmation first, and the dialog is explicit about the consequence: *"Deleting #12 will void its journal entry in the general journal."* Deleting is therefore not a quiet edit — the books are corrected.

## Which of the Two to Use

- Money arrived? **Record Payment**.
- The charge was wrong, or part of the work was returned? **Credit Note**.
- The client never owed anything on that document at all? Void the invoice instead — see [Invoicing](/ledgerik/manual/invoices-and-sales/).
