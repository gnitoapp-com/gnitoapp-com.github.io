---
title: Company Settings
summary: Company setup, tax codes and email — the three settings that live here, and where the rest are documented.
layout: manual
menu: {manual: {weight: 130}}
---

**Company Settings** holds configuration: seven entries, none of them reports and none of them day-to-day work.

| Entry | What it is | Where it is documented |
| --- | --- | --- |
| Company Setup | the company's own facts | below |
| List Tax Codes | tax rates the books use | below |
| Email Settings | the mail account and its templates | below |
| List Currencies | exchange rates | [Currencies](/ledgerik/manual/currencies/) |
| List Contacts | customers and vendors | [Contacts](/ledgerik/manual/contacts/) |
| Backups | snapshots, restore, encrypted export | [Backups, Import & Restore](/ledgerik/manual/backups/) |
| Import Data | CSV import | [Backups, Import & Restore](/ledgerik/manual/backups/) |

## Company Setup

The same four tabs you filled in when the company was created — **Company Information**, **Fiscal Year**, **Base Currency** and **Accounts** — reachable again whenever you need them.

What each one allows:

- **Company Information** — name, tax numbers, address, contact details. Change them whenever the facts change.
- **Base Currency** — locked once a currency exists; the selector is disabled. See [Currencies](/ledgerik/manual/currencies/).
- **Fiscal Year** — the year and its last month are set once. After that the year field is read only, and the last-month selector stops responding. To choose where the **next** year ends, use the close window instead — see [Year End](/ledgerik/manual/year-end/).
- **Accounts** — maps the eight company account references, and the tab stays disabled until company setup is complete. See [Company account references](/ledgerik/manual/chart-of-accounts/company-account-references/).

## Sales tax codes

**List Tax Codes** holds the **sales tax rates** your postings use — GST, HST, VAT, PST, and whatever else you charge or are charged. A code is three things: a **Tax Code**, a **Tax Code Description** and a **Tax Rate Percent**.

**New** adds one, **Edit** changes it, **Delete** asks first, naming the code.

These are rates, not classifications. They are **not** the tax-return classification codes that tell a filing form which line a figure belongs on — that is a separate field on each **account**, the **Tax Return Code** in [Accounts (Chart of Accounts)](/ledgerik/manual/chart-of-accounts/), and the two are unrelated.

A sales tax code does three jobs:

- **it puts tax on a line.** An invoice line, an expense or a journal line can carry one, and the tax lines in the ledger come from its rate.
- **it records the rate on the posting.** The rate travels with the line into the journal, which is what the tax return reports on.
- **it groups the [Tax Return](/ledgerik/manual/reports/other-reports/)** by rate — one row per rate used, not one row per classification code.

Editing a rate carries a warning in the form itself: *"The new rate will not affect existing transactions."* That is exact — postings keep the rate they were made with, and only new lines use the new one. Deleting a code that postings still reference is refused for the same reason a used currency cannot be deleted.

## Email Settings

Three tabs.

**SMTP** is the mail account invoices, estimates and reminders are sent from:

- **SMTP Host** and **Port**
- **Use TLS**
- **Username** — optional
- **Password** — *"The password is stored in the OS keychain and never written to the company file."*
- **From Address**

**Test Connection** sends nothing: it opens a connection and reports *"Connection successful."* or *"Connection failed. Check the settings."* **Save** stores the settings and confirms with *"Email settings saved."*

**Templates** holds the wording for the three mails Ledgerik sends — an invoice, an estimate and a reminder — each with a subject and a body. Merge fields are listed beside the fields, so the wording can name the client and the document.

**Outbox** lists the mails Ledgerik has queued, sent or failed, and **Retry Pending** re-sends the ones that did not go.

Nothing is sent from a window you are not looking at: an invoice is emailed when you press **Email to client**, and a reminder when you press **Send**.

## Where the rest of it lives

- **Currencies** — [Currencies](/ledgerik/manual/currencies/)
- **Contacts** — [Contacts](/ledgerik/manual/contacts/)
- **Backups** and **Import Data** — [Backups, Import & Restore](/ledgerik/manual/backups/)

Company Setup, Currencies, Tax Codes and Backups are free on Ledgerik Basic. **Contacts, Email Settings and Import Data are Pro** — see [Licensing](/ledgerik/manual/licensing/).
