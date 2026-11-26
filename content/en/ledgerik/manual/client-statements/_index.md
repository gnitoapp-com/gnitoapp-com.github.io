---
title: Client Statements
summary: What a client owes, printed as a statement you can hand over.
layout: manual
menu: {manual: {weight: 140}}
---

A client statement is one client's account with you, laid out chronologically and exportable to PDF. It is history, not a document you write: nothing on it can be edited, and nothing is sent from it.

## Two places, one subject

- **Client Portal ▸ Client Portal** picks a client and shows their account on screen.
- **Statement** opens the formal statement, printable and exportable, for that client.

The **Statement** action appears in two places, and both reach the same window: on a row of **Company Settings ▸ Contacts**, and on a row of **Reporting ▸ AR Aging**.

## The portal view

Choose a client from **Select Client**. With none chosen the window says **"Select a client to view their account."**

The account is then shown in three figures — **Invoiced**, **Paid** and **Balance** — followed by three lists: **Invoices**, **Estimates** and **Payments**, each with its empty state.

This is a read-only view of what the client has been sent and what they have paid. Nothing here posts, voids or changes anything.

## The formal statement

**Statement** opens **Statement — {client}** with four totals at the top:

- **Opening** — the balance carried in from before the period
- **Invoiced** — what the period billed
- **Paid** — what the client paid
- **Closing** — opening plus the period's activity

Then a table, one row per event, in date order, with the columns **Date**, **Description**, **Reference**, **Debit** and **Credit**: each invoice as a debit, each payment and each credit note as a credit.

The arithmetic is stated so it cannot be guessed at. The opening balance is the activity before the period. The period lists every invoice, payment and credit note in date order. Closing is opening plus that activity.

Everything on the statement is in the **base currency**. Foreign invoices are converted at the rate stored on the invoice, not at today's rate — see [Currencies](/ledgerik/manual/currencies/).

**Export PDF** writes the statement out as a document. That is how it reaches a client: Ledgerik does not email it for you.

## What a statement does not do

- **Not a portal the client logs into.** There is no login, no share link and nothing published online; the client receives the PDF from you.
- **Not a report you can change.** No filters, no date range, no choice of columns — the statement covers the client's whole history.
- **Not a document to fix a problem with.** A wrong invoice is voided and re-issued, or reduced with a credit note; the statement then shows the result — see [Invoicing](/ledgerik/manual/invoices-and-sales/).

Both windows are Ledgerik **Pro** — see [Licensing](/ledgerik/manual/licensing/).
