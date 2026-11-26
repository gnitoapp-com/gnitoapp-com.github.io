---
title: Weighted average cost
summary: How Ledgerik values a foreign-currency account when it is reduced, and where the difference goes.
layout: manual
---

## The Rule

Valuing a foreign-currency disposal is the part the application never shows you, and it decides what the disposal is worth.

An account that holds a foreign currency has two stored balances: its native balance and its base balance. The book average is the base balance divided by the native balance.

When a posting **reduces** such an account, Ledgerik values the reduction at the book average rather than at the journal's rate. It applies when three things are true at once:

- the account's currency is not the base currency;
- the account's currency matches the journal's currency;
- the movement reduces the account, which means its sign is opposite to the balance it is reducing.

There are then two cases.

- **The reduction empties the account.** The base amount taken out is exactly the base balance the account still holds. Nothing is left behind.
- **The reduction is partial.** The base amount is the native reduction multiplied by the book average.

Two things follow, and they are the reason the model exists. The average cost of the units still on the account does not change. And the base balance stays proportional to the native balance, so a partial disposal can never consume the account's base value out of proportion.

### A Movement That Increases the Account

An increase needs no repricing. The new units are valued at the journal's rate, the account's balances grow by both amounts, and the average is recalculated from the new totals.

Start from 100 EUR and 150 CAD, an average of 1.50. Record another 50 EUR at 1.80. That adds 90 CAD, so the account holds 150 EUR and 240 CAD — an average of 1.60.

The average has moved towards the rate of the new units, weighted by their size. When that balance is reduced later, it is the new average that values the reduction, not the rate of that later day.

### Emptying an Account Leaves Nothing Behind

When a reduction empties a foreign-currency account, the base balance goes to zero with it. Exactly, not approximately.

For that line Ledgerik does not use the day's rate at all. It takes out the base amount the account still carries, so native and base reach zero together.

This failure is common. An account can read zero in its own currency while still holding a base-currency amount. Nothing is left to move it, so the residue sits there for good. Because the emptying line is valued from the account rather than from the rate, that cannot happen here.

The guarantee holds whenever the emptying movement is in the account's own currency, which is the only currency Ledgerik offers for that account.

### Worked Example

Suppose the company keeps its books in CAD, and holds a bank account in EUR.

1. You record 100 EUR at a rate of 1.50. The account now holds 100 EUR and 150 CAD. Its average is 1.50.
2. Later you dispose of 40 EUR, and the journal for that day carries a rate of 1.60.

At the journal's rate, the 40 EUR would be worth 64 CAD. But the line reduces the account, so it is valued at the book average instead: 40 × 1.50 = **60 CAD**.

The account is left with 60 EUR and 90 CAD. Its average is still 1.50. The remaining units were not revalued by a later rate.

3. Finally you dispose of the last 60 EUR, and the day's rate is 1.70. At that rate they would be worth 102 CAD. The line empties the account, so Ledgerik takes out exactly the 90 CAD still on it.

The account now reads 0 EUR and 0 CAD. Neither side left a residue behind, and the 12 CAD difference from the third journal goes to Exchange Gain/Loss.

## Where the Difference Goes

The two sides of a foreign-currency journal rarely agree in the base currency. In the second journal above, one side gives up 60 CAD and the other receives 64 CAD.

After all its lines are posted, a journal whose base total is not zero gets one more line. The remainder goes to the **Exchange Gain/Loss** account, with the memo **realized currency exchange gain** or **realized currency exchange loss**. The second journal takes 4 CAD there as a gain, the third 12 CAD.

**Exchange Gain/Loss** is a company account reference, not a fixed account name. It is whichever account the **Accounts** tab of company setup maps to that reference, and it is an Income-class account by default.

Every line is rounded in its own currency's minor unit. The gain or loss line is sized from the rounded lines, so the journal balances to the cent.

## Voiding a Foreign Transaction

A void does not undo a valuation. Its reversing lines are ordinary movements, so a line that reduces a foreign-currency account is repriced at the book average like any other.

If the rate has moved since the original entry, the difference between the original rate and the book average appears as an exchange gain or loss. That is correct: the currency did change value, and the books record it.

Back to [Currencies](/ledgerik/manual/currencies/).
