---
title: Receipts
summary: The files attached to expenses, where they are kept, and what happens when one goes missing.
layout: manual
---

A receipt is a file attached to an expense: a photo of a paper slip, a scan, or a PDF. **Receipts ▸ Receipt Gallery** shows every one of them in a single gallery.

## Attaching a receipt

Open an expense and choose **Attach…**. Pick the file and Ledgerik confirms with *"Receipt attached."*

From then on the expense carries the receipt. An expense can be saved without one, and it can hold several.

## Where the files are kept

Attaching copies the file into Ledgerik's own receipts folder, inside the application's documents directory. The copy gets a new name and a checksum, so moving or renaming the original afterwards changes nothing.

This has one consequence worth knowing. **Receipts are not inside the company file.** A company file is one `.acw` file holding the books; the receipts live beside the application, in their own folder. Backing up the company file therefore does not back up the receipts — see [Backups, Import & Restore](/ledgerik/manual/backups/).

## The gallery

**Receipts ▸ Receipt Gallery** lists every receipt across every expense, with the merchant and the date, and the gallery says so at the top: *"All receipts stored with your expenses. Missing files show a placeholder."*

A receipt whose file has gone shows a placeholder instead of a preview, and opening it reports *"The receipt file is missing."* The expense itself is unaffected.

## Deleting a receipt

Deleting a receipt asks first, naming the file. The attachment goes; the expense stays, with its amounts and its journal entry untouched.

That is the difference between deleting a receipt and deleting an expense: the receipt is evidence, the expense is the bookkeeping. Only the second one touches the books.

## What a receipt does not do

A receipt does not change an expense's amount, its account or its tax code. Nothing reads a receipt's contents: there is no scanning of amounts or dates in this build, and no automatic matching of a receipt to an expense.
