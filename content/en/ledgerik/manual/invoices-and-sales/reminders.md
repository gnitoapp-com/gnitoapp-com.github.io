---
title: Reminders
summary: Chasing invoices that are due, on a schedule or by hand.
layout: manual
---

**Invoicing ▸ Reminders** holds two things: the settings that decide how reminders are written, and a log of the ones already sent.

## The reminder settings

Three fields make up a reminder.

- **Days Before Due** — how many days before the due date the reminder is meant to go out. The default is 3.
- **Email Subject**
- **Email Body**

Placeholders are available in the subject and the body, and the window lists them next to the fields, so the wording can name the invoice and its amount.

**Save settings** stores them. Ledgerik confirms with *"Reminder settings saved."*

**Nothing is sent automatically.** Ledgerik sends no reminder on its own, whatever the days-before setting says. Every reminder goes out because you pressed **Send** — the setting is a note of what the wording is intended for, and it is stored with the rest.

## Sending a reminder

Below the settings is the list of invoices that are not paid. Each row shows the invoice and when it is due, with a **Send** action.

Sending mails that reminder immediately and reports it: *"Reminder email sent for invoice #12."*

If every invoice is paid, the list says so: **"All invoices are paid."**

## The reminder log

**Reminder Log** lists the reminders that have been sent, newest first. An empty log reads *"No reminders sent yet."*

The log is a record of what went out, not a queue of what is pending.

## What a reminder does not do

A reminder does not change an invoice. It does not mark it sent or paid, does not post a journal entry, and does not touch the books.

Email needs a working mail account under **Company Settings ▸ Email Settings** — see [Company Settings](/ledgerik/manual/settings/). Without one, nothing is delivered.
