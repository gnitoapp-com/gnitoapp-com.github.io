---
title: Estimates
summary: Quoted work for a client, and how an estimate becomes an invoice.
layout: manual
---

An estimate is a quote. It runs through its own list, and it can be turned into an invoice when the client accepts it.

**Invoicing ▸ List Estimates** shows them all, with number, client, status and total.

## Creating an estimate

**Invoicing ▸ Create Estimate** opens the same editor the invoice uses, minus the parts that only an invoice needs.

- **Client** — required.
- **Currency** — the estimate's own currency, with a **Rate to Base Currency** field when it is not the base currency.
- **Issue Date** and **Expiry Date** — when the quote was made, and when it stops being valid.
- **Line items** — **Add Line**, then a **Description**, a **Qty**, a **Rate**, an **Account**, an optional **Sales Tax Code** and an optional per-line **Discount**.
- **Estimate discount** — applied to the whole document, as a percentage or a fixed amount.
- **Notes** and **Terms**.

**Preview** renders the estimate as the client will receive it.

## Statuses

- **Draft** — being written.
- **Sent** — issued to the client.
- **Accepted** — the client took the quote.
- **Declined** — the client turned it down.
- **Expired** — the expiry date has passed.
- **Invoiced** — already turned into an invoice.

## Converting to an invoice

**Convert** turns the accepted estimate into an invoice, carrying over the client, the currency, the lines and the discount. Ledgerik reports *"Estimate #12 converted to invoice."* and the estimate's status becomes **Invoiced**.

From that point the invoice is the document that matters. It is created as a draft, so it is edited, finalized, emailed and voided like any other — see [Invoicing](/ledgerik/manual/invoices-and-sales/).

## Sending an estimate

**Email to client** sends the estimate to the address on the client's [contact](/ledgerik/manual/contacts/) record. Email needs a working mail account under **Company Settings ▸ Email Settings**.

## What an estimate does not do

An estimate never touches the books. It creates no journal entry, raises no receivable, and appears in no financial statement. Only the invoice it becomes does that.
