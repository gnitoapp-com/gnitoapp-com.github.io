---
title: Stripe payments
summary: Taking a card payment for an invoice, and the keys that make it work.
layout: manual
---

**Invoicing ▸ Stripe Payments** takes a card payment for an invoice inside Ledgerik. It has two tabs: **Settings** and **Process Payment**.

## Settings

Stripe needs two keys, both from your Stripe account.

- **Publishable Key** — identifies your account to Stripe's checkout.
- **Secret Key** — authenticates the payment from the application. It is stored securely, and once one is stored the field says so and keeps the current value unless you replace it.

**Save settings** stores them. When both are in place the window reports **"Stripe is configured."**

## Processing a payment

On the **Process Payment** tab, choose the invoice and the account to **Deposit To**, then **Pay with Stripe**. Stripe takes the card details; Ledgerik never receives them.

Two outcomes are reported.

- **Payment confirmed and recorded**, with the payment reference. The invoice is settled exactly as if you had recorded the payment by hand.
- **Payment not confirmed in the wait period.** Stripe has not finished confirming yet, so nothing is recorded. Check the payment in Stripe before you try again, or record it manually with [Record Payment](/ledgerik/manual/invoices-and-sales/payments-and-credit-notes/).

Two things are checked before anything starts. Stripe must be configured, and a deposit account must be chosen; the window says which of the two is missing.

## What it does to the books

A confirmed Stripe payment is recorded as an ordinary payment, through the same path as [Record Payment](/ledgerik/manual/invoices-and-sales/payments-and-credit-notes/): the deposit account is debited, the receivables account is credited, and the invoice becomes paid once it is covered. The payment keeps Stripe's own reference, so it can be matched against the Stripe dashboard. Nothing separate is posted for the card processor.

The whole Invoicing group is Ledgerik Pro, this entry included — see [Licensing](/ledgerik/manual/licensing/).
