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

Attaching copies the file into the company's receipts folder. That folder sits **beside the company file** and is named after it: a company file called `Acme.acw` has `Acme_receipts` next to it. The copy gets a new name and a checksum, so moving or renaming the original afterwards changes nothing.

Because the receipts live next to the company file, the two travel together. Move the folder, or move both files together, and every attachment still opens. Copy only the `.acw` and the receipts stay behind.

## Receipts and backups

The encrypted export — **Company Settings ▸ Backups ▸ export** — packs the company file **and every receipt** into one `.acwz`, and restoring it puts the receipts back beside the restored file. That is the artefact to move a company to another machine, or to another operating system.

The automatic snapshots taken while you work are different: they hold the company file only. They protect the books, not the attachments. See [Backups, Import & Restore](/ledgerik/manual/backups/).

## The gallery

**Receipts ▸ Receipt Gallery** lists every receipt across every expense, with the merchant and the date, and the gallery says so at the top: *"All receipts stored with your expenses. Missing files show a placeholder."*

A receipt whose file has gone shows a placeholder instead of a preview, and opening it reports *"The receipt file is missing."* The expense itself is unaffected.

## Deleting a receipt

Deleting a receipt asks first, naming the file. The attachment goes; the expense stays, with its amounts and its journal entry untouched.

That is the difference between deleting a receipt and deleting an expense: the receipt is evidence, the expense is the bookkeeping. Only the second one touches the books.

## What a receipt does not do

A receipt does not change an expense's amount, its account or its sales tax code. Nothing reads a receipt's contents: there is no scanning of amounts or dates in this build, and no automatic matching of a receipt to an expense.
