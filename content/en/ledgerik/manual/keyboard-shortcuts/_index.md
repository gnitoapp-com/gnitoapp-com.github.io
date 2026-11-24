---
title: Keyboard Shortcuts & Command Palette
summary: The nine shortcuts Ledgerik registers, the reference overlay, and the two search boxes.
layout: manual
menu: {manual: {weight: 160}}
---

Ledgerik registers **nine keyboard shortcuts**. All of them work from anywhere in the application, and none of them can be changed.

## The shortcuts

| Keys | Action | Group |
| --- | --- | --- |
| **Ctrl+K** | Command Palette | General |
| **Ctrl+F** | Global Search | General |
| **Ctrl+/** | Shortcut Reference | General |
| **Ctrl+,** | App Settings | General |
| **Ctrl+N** | New Invoice | Sales |
| **Ctrl+E** | New Estimate | Sales |
| **Ctrl+I** | Invoices | Sales |
| **Ctrl+T** | Time Tracker | Projects & Time |
| **Ctrl+J** | New Journal Entry | Accounting |

**On macOS the modifier is ⌘**, and the labels say so: ⌘K, ⌘F, ⌘/, ⌘,, ⌘N, ⌘E, ⌘I, ⌘T, ⌘J. Option and Shift are shown as ⌥ and ⇧.

## The reference overlay

**Ctrl+/** opens a list of every shortcut, grouped exactly as above. It is an **overlay over the application**, not a window: it has no menu entry and nothing to open from the menu bar, which is why the shortcut is the only way to reach it.

Press **Escape** or the same combination again to close it.

## Ctrl+K — the command palette

The palette is a search box for the application itself. Type part of a name — *Invoice*, *Trial*, *Backup* — and it offers matching windows; choose one and it opens.

Two things shape what it can find:

- **It lists windows that need no further arguments.** A window that needs a particular record — an edit screen, a statement for one client — is not offered by name, because there is nothing for the palette to fill in. Reach those from their list and a **Statement** or **Edit** action.
- **It follows your plan.** Pro windows appear in the palette only on Ledgerik Pro; on Basic they are absent rather than shown and refused — see [Licensing](/ledgerik/manual/licensing/).

Typing something with no match says **"No matches"**.

## Ctrl+F — global search

Global search looks for **records**, not windows. It searches four kinds:

- **contacts**
- **invoices**
- **accounts**
- **journals**

A search returns up to eight results per kind, so a broad term stays readable. Contacts and invoices belong to Pro features, so on Ledgerik Basic only accounts and journals are searched — the other two are not queried at all.

An empty box returns nothing: the search needs a term before it looks.

## What is not here

- **No shortcut editor.** The nine combinations are fixed; the settings file can hold overrides, but nothing in the interface writes them.
- **No shortcuts for lists or editors.** There are no keys for saving, deleting, confirming or moving between rows.
- **No printable reference.** The overlay is the reference, and it is on screen when you need it.
