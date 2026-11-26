---
title: Receipts
summary: The files attached to expenses, where they are kept, and what happens when one goes missing.
layout: manual
---

A receipt is a file attached to an expense: a photo of a paper slip, a scan, or a PDF. **Receipts ▸ Receipt Gallery** shows every one of them in a single gallery.

## Attaching a Receipt

Open an expense and choose **Attach…**. Pick the file and Ledgerik confirms with *"Receipt attached."*

From then on the expense carries the receipt. An expense can be saved without one, and it can hold several.

## Where the Files Are Kept

Attaching copies the file into the company's receipts folder. That folder sits **beside the company file** and is named after it: a company file called `Acme.acw` has `Acme_receipts` next to it. The copy gets a new name and a checksum, so moving or renaming the original afterwards changes nothing.

Because the receipts live next to the company file, the two travel together. Move the folder, or move both files together, and every attachment still opens. Copy only the `.acw` and the receipts stay behind.

## Receipts and Backups

The encrypted export — **Company Data ▸ Backups ▸ export** — packs the company file **and every receipt** into one `.acwz`, and restoring it puts the receipts back beside the restored file. That is the artefact to move a company to another machine, or to another operating system.

The automatic snapshots taken while you work are different: they hold the company file only. They protect the books, not the attachments. See [Company Data](/ledgerik/manual/company-data/).

## The Gallery

**Receipts ▸ Receipt Gallery** lists every receipt across every expense, with the merchant and the date, and the gallery says so at the top: *"All receipts stored with your expenses. Missing files show a placeholder."*

A receipt whose file has gone shows a placeholder instead of a preview, and opening it reports *"The receipt file is missing."* The expense itself is unaffected.

## Deleting a Receipt

Deleting a receipt asks first, naming the file. The attachment goes; the expense stays, with its amounts and its journal entry untouched.

That is the difference between deleting a receipt and deleting an expense: the receipt is evidence, the expense is the bookkeeping. Only the second one touches the books.

## Pruning Old Receipts

Receipts are the only part of a company that grows without limit: the ledger is rows, the receipts are images and PDFs. **Receipts ▸ Receipt Storage** is where you thin them.

The window opens with what the folder holds — *"1 file, 12 MB"* — and asks for **Remove receipts before**. A date there selects every receipt whose **expense** is dated before it, and the window previews the result before anything happens: *"412 receipts, 380 MB, dated before 2020-01-01"*.

**Remove the receipt records as well** is off by default, and the hint says what that means: *"Off: each receipt stays in the gallery and shows a placeholder where its file was."* Turn it on and the rows go too. Either way **Remove Receipts** changes no expense, no amount and no journal entry.

Three things guard the cutoff:

- **A backup of the company file is taken first**, and the confirmation says the awkward part out loud: the files are not in the company file, so that backup does not carry them. Only an encrypted export does.
- **An open fiscal year is refused.** A receipt is evidence for a deduction, so the cutoff has to sit behind a closed period: *"The cutoff falls inside the open fiscal year … Close it, or choose an earlier date."*
- **A cutoff inside the last six years asks you to type the date** before it proceeds, because that is where the evidence still matters.

Shared files are safe: two receipts with identical contents point at one file, and it is kept while either receipt remains.

The result reports what happened — *"412 files removed, 380 MB freed."* — and whether the receipts were kept with placeholders or removed with their rows. A date with nothing before it says *"No receipt is dated before …"*. The prune is recorded in the [Audit Log](/ledgerik/manual/reports/audit-log/).

Receipt Storage is Ledgerik **Pro**; the Receipt Gallery is not — see [Licensing](/ledgerik/manual/licensing/).

## What a Receipt Does Not Do

A receipt does not change an expense's amount, its account or its sales tax code. Nothing reads a receipt's contents: there is no scanning of amounts or dates in this build, and no automatic matching of a receipt to an expense.
