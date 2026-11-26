---
title: Contacts
summary: Customers and vendors — the details they carry, what the currency field does, and what happens when you delete one.
layout: manual
menu: {manual: {weight: 50}}
---

A contact is one record for a person or a company you trade with. Invoices, estimates, expenses and statements all point at a contact.

Contacts live under **Company Settings ▸ Contacts**.

## Type and designation

Every contact carries two labels, and both are required.

**Contact Type** is either **Customer** or **Vendor**. It says which side of the books the record serves. Customers appear on invoices and estimates; vendors appear on expenses and in the 1099-NEC report.

**Designation** is either **Individual** or **Company**. It records what kind of counterparty this is, and it is shown next to the type in the list.

## Adding a contact

Choose **New** in the contacts list. The form asks for:

- **Contact Type** — required.
- **Designation** — required.
- **Contact Name** — required.
- **Currency** — required.
- **Sales Tax Code** — optional, with **None** as the default.
- **Email** and **Phone** — optional. An email address is checked for shape.
- **Tax ID (EIN / VAT)** — optional.
- **Address (optional)** — two address lines, city, state or province, postal code and a country ISO code.

## What the currency field does

The currency on a contact is recorded and displayed. It appears in the list and in the CSV export.

It does **not** set the currency of anything. An invoice's currency is chosen on the invoice itself, and a statement shows each document in the currency that document was written in. See [Currencies](/ledgerik/manual/currencies/).

## The list

Each row shows the contact's name and a line with the type, the designation and the currency. Three actions sit at the right of every row.

- **Statement** — opens that contact's statement — see [Client Statements](/ledgerik/manual/client-statements/).
- **Edit** — opens the record.
- **Delete** — see below.

**Export CSV** writes the list to a file with the columns Name, Type, Designation, Currency, Sales Tax Code, Email, Phone and Tax Id.

## Deleting a contact

**Delete** asks first. The confirmation names the contact, warns that the change cannot be undone, and does nothing unless you confirm.

Three things are worth knowing before you use it.

- **A contact that is already in use cannot be deleted.** Invoices and expenses point at their contact, and the database refuses to remove a record that others refer to. The attempt fails, Ledgerik reports the failure, and the contact stays — so no document is ever left without a counterparty.
- **The outcome is always reported.** A successful delete says so; a refused one says why instead of failing silently.
- **The deletion is recorded.** Removing a contact writes an entry to the Audit Log, which is described in [Audit Log](/ledgerik/manual/reports/audit-log/).

## The 1099 contractor flag

**1099 Contractor (paid for services)** is a switch on the contact form, with the note *"Flags vendor contacts for 1099-NEC reporting."*

Turn it on for a vendor you paid for services and whose payments belong on a 1099-NEC. Only vendor contacts appear in that report, so the flag on a customer changes nothing. The report itself is described in [Reporting](/ledgerik/manual/reports/).

## Where contacts are used

- **Invoices** — the client on an invoice is a contact. Any contact can be chosen, whatever its type. See [Invoicing](/ledgerik/manual/invoices-and-sales/).
- **Expenses** — the vendor on an expense is a contact.
- **Estimates** — the client on an estimate is a contact.
- **Statements** — built from one contact's invoices, payments and credit notes.
- **1099-NEC** — reads the vendor contacts you flag as contractors.

## Sales tax codes on a contact

The **Sales Tax Code** field on a contact is optional and independent of the sales tax code on a line of an invoice or an expense. The codes themselves are maintained under **Company Settings ▸ List Sales Tax Codes**.
