---
title: Currencies
summary: The company's base currency, the rates you enter, and how a foreign-currency posting is valued.
layout: manual
menu: {manual: {weight: 45}}
---

A company keeps its books in one currency: the base currency. Every report total is in it.

Transactions may be recorded in other currencies. Each one carries a rate to the base currency. This section explains what Ledgerik does with that rate.

## The base currency

You choose the base currency during company setup, on the **Base Currency** tab. Pick with care. Once a company has a base currency, it cannot be changed — the selector is disabled from that moment on.

The base currency is stored inside the company file. So is every rate.

## The currency list

**Company Settings ▸ List Currencies** shows the currencies the company uses.

Each row carries the currency code, its name, a sample amount, and the rate to base. The base currency carries a **BASE** chip. It has no edit button and no delete button, because it has no rate to maintain.

**Add Currency** asks for two things:

- the currency itself, chosen from a searchable list;
- the **Exchange Rate to Base**, a positive number.

Under the rate, Ledgerik shows what the number means: `1 EUR = 1.09 CAD`.

**Change Currency** edits the rate. The form says: *"The new rate will not affect existing transactions."* That is exact, and worth understanding.

Every posting stores two amounts: the amount in its own currency, and the amount in the base currency. An invoice keeps the rate it was written at. Changing a currency's rate therefore changes only the postings made after the change. Nothing is revalued, and no past figure moves.

A currency cannot be deleted while an account uses it: *"The EUR currency cannot be deleted because it is used in accounts."*

## Where the rate is used

A journal entry carries a currency and a rate to base. Each line of that journal is posted at the rate: base amount equals native amount times rate.

A foreign-currency invoice needs a valid rate before it can be finalized. Ledgerik refuses to finalize one with no rate, a zero rate or a negative rate.

Only some accounts may hold a foreign currency: those in the **Asset**, **Liability** and **Equity** classes. The income and expense classes stay in the base currency. See [Accounts (Chart of Accounts)](/ledgerik/manual/chart-of-accounts/).

## How a foreign-currency posting is valued

A foreign-currency posting is not simply converted at the day's rate. When a movement reduces an account that holds that currency, Ledgerik values the reduction at the account's own **book average**: the base balance divided by the native balance.

The rule applies when three things are true at once:

- the account's currency is not the base currency;
- the account's currency matches the journal's currency;
- the movement reduces the account, so its sign is opposite to the balance it reduces.

One of two things then happens.

- **The reduction empties the account.** The base amount taken out is exactly the base balance still on it. So zeroing a foreign-currency account cannot leave a base-currency residue behind — the failure where an account reads zero in its own currency while still carrying a base amount, with nothing left to clear it.
- **The reduction is partial.** The base amount is the reduction multiplied by the book average, so the average of what remains does not move.

Either way, whatever the two sides of the journal disagree by in the base currency goes to **Exchange Gain/Loss**, with the memo *realized currency exchange gain* or *realized currency exchange loss*. Voiding a foreign transaction is priced the same way.

[Read the full details of weighted average cost](/ledgerik/manual/currencies/weighted-average-cost/) — the three-journal worked example, the rounding rule, and what a void does to the account's average.
