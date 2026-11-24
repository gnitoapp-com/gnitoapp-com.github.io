---
title: Invoicing
summary: Invoices from draft to posted journal entry, and the other eight entries of the Invoicing menu.
layout: manual
menu: {manual: {weight: 60}}
---

The **Invoicing** group holds nine entries. This page covers invoices themselves — the document, its statuses, and what finalizing does to the books. The other eight have their own pages, listed at the end.

## The invoice list

**Invoicing ▸ List Invoices** shows every invoice with its number, its client, its status and its total.

Each row offers the actions that are legal for that invoice: edit, finalize, void, email to the client, and a PDF preview. Voided and posted invoices do not offer editing.

The empty list says so: *"No invoices yet. Create your first invoice."*

## Numbering

Ledgerik numbers invoices itself. The next invoice takes a number one more than the highest already used, and numbers are never reused — a voided invoice keeps its number.

## Creating an invoice

**Invoicing ▸ Create Invoice** opens the editor.

**The header** asks for:

- **Client** — required. Any [contact](/ledgerik/manual/contacts/) can be chosen, whatever its type.
- **Currency** — the invoice's own currency.
- **Issue Date** and **Due Date**.
- **Rate to Base Currency** — appears when the currency is not the base currency. A foreign-currency invoice will not finalize without a positive rate. See [Currencies](/ledgerik/manual/currencies/).

**Line items** are added with **Add Line**. Each line carries a **Description**, a **Qty**, a **Rate**, an **Account** and an optional **Sales Tax Code**. A line can also carry its own **Discount**, as a percentage or a fixed amount. The account is required: it decides where the line lands in the ledger, and the picker offers only the accounts that can take a posting.

**The invoice discount** applies to the document as a whole, again as a percentage or a fixed amount.

Below the lines Ledgerik shows the running totals: subtotal, tax, discount and total, in the invoice's currency.

**Notes** and **Terms** are free text, and **Preview** renders the invoice as the client will receive it.

## Statuses

An invoice carries one of six statuses.

- **Draft** — being written. It can be edited.
- **Sent** — issued to the client.
- **Viewed** — the client has opened it.
- **Paid** — settled by one or more payments.
- **Overdue** — the due date has passed and the invoice is not settled.
- **Voided** — cancelled. The invoice stays in the list and keeps its number.

Only a draft can be edited. Once it is sent, the editor says so: *"This invoice is Sent and cannot be edited. Void it and create a new invoice to make changes."*

## Finalizing

**Finalize** posts the invoice to the general journal. That is the step that changes the books: until it is finalized, an invoice is a document, not an accounting entry.

Finalizing raises the receivable on the invoice's account for receivables reference, records the income and tax lines from the invoice's own accounts and sales tax codes, and converts every line to the base currency at the invoice's rate. The difference, if any, is handled exactly as described in [Currencies](/ledgerik/manual/currencies/) — the invoice's own entries are ordinary journal lines.

See [Journal Entries](/ledgerik/manual/journal-entries/) for what a posted entry looks like.

## Voiding

**Void** asks for confirmation, then reverses the invoice's journal entry rather than deleting anything. The invoice keeps its number and its history, and your reports stop counting it as outstanding.

A voided invoice cannot be paid, and cannot be edited back into life.

## Sending an invoice

**Email to client** sends the invoice to the client's email address. It needs a working mail account first, configured under **Company Settings ▸ Email Settings** — see [Company Settings](/ledgerik/manual/settings/).

The client's email address is the one on their [contact](/ledgerik/manual/contacts/) record, so an invoice cannot be emailed to a contact without one.

## The other entries in the group

Each of these has its own page.

- **Estimates** — [Estimates](/ledgerik/manual/invoices-and-sales/estimates/): quoted work, convertible to an invoice.
- **Record Payment** and **Credit Notes** — [Payments and credit notes](/ledgerik/manual/invoices-and-sales/payments-and-credit-notes/): money received, and money taken off.
- **Recurring Invoices** — [Recurring invoices](/ledgerik/manual/invoices-and-sales/recurring-invoices/): a series that issues invoices on a schedule.
- **Reminders** — [Reminders](/ledgerik/manual/invoices-and-sales/reminders/): chasing invoices that are due.
- **Stripe Payments** — [Stripe payments](/ledgerik/manual/invoices-and-sales/stripe-payments/): taking a card payment in the application.

## Pro or Basic

Every entry in the Invoicing group is Ledgerik **Pro**. The general ledger, the chart of accounts, journals, the three financial statements and backups are free; invoicing is not — see [Licensing](/ledgerik/manual/licensing/).

## What invoices affect

- **The general journal** — on finalize and on void.
- **The account for receivables** — every unpaid invoice raises it.
- **The home screen** — invoiced, paid and outstanding figures, overdue invoices and AR aging.
- **The reports** — income statement, balance sheet, cash flow and AR aging, all in [Reporting](/ledgerik/manual/reports/).
