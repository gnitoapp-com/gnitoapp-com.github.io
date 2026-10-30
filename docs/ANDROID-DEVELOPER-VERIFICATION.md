# Android developer verification: registering as a developer and registering our apps

Practical runbook for **GnitoApp.com (3827992 Canada Inc.)**, which distributes its
Android apps from this website only. Written 2026-10-30 against Google's published
documentation; every factual claim below links to the page it came from, and those
pages carry their own "last updated" dates — re-check the FAQ before relying on a
detail months from now.

> We have no Google Play developer account (it was terminated and must not be
> re-created). Distribution is direct download from gnitoapp.com, so the path here is
> the **Android Developer Console (ADC)** — *not* Play Console. The ADC is a separate
> console for developers who distribute exclusively outside Play.

---

## 1. What the programme is, and when it bites

| Fact | Detail |
| --- | --- |
| What it does | Binds an app's **package name** and **signing-key certificate** to a **verified developer identity**; certified Android devices check that binding at install time |
| Enforcement start | **2026-09-30** in Brazil, Indonesia, Singapore and Thailand, for the seven participating stores (Google Play, HONOR, OPPO, Samsung, Transsion, vivo, Xiaomi) |
| Global rollout | **2027**, for all apps on certified Android devices |
| Devices affected | Certified devices running **Android 7 or higher**; the check ships through Google Play services |
| Not affected | Installs over **ADB** always work; unregistered apps can still be installed via ADB or the **advanced flow** (a one-time user opt-in) |
| Unregistered today | In the four rollout countries, users of our site would need ADB or advanced flow; elsewhere nothing changes until 2027 |

Sources: [Android developer verification](https://developer.android.com/developer-verification),
[FAQ](https://developer.android.com/developer-verification/guides/faq).

Our apps currently have **no registration**, so this is outstanding work that becomes
mandatory for a smooth install everywhere in 2027 — and is already relevant for any
user in the four launch countries.

---

## 2. Pick the account type

| | Full distribution | Limited distribution |
| --- | --- | --- |
| For | Public distribution (our case) | Students/hobbyists, testing |
| Apps/installs | Unlimited | Up to **20 devices** the user explicitly authorises |
| Fee | **US$25** registration fee (Google's FAQ describes it as covering administrative costs and compares it to Play's registration fee; it does not say it recurs) | Free |
| Identity | Government photo ID + proof of address; organisations also need D-U-N-S and business documents | No ID |
| Can it be converted? | — | Limited → full is supported; full → limited is **not** |

We need **full distribution**: our APKs are public downloads with no device cap.
Sources: [Register for full distribution](https://developer.android.com/developer-verification/guides/full-distribution),
[FAQ](https://developer.android.com/developer-verification/guides/faq).

---

## 3. Lead time: do these three things first

The identity step takes ~10 minutes *if* the documents are ready, but two
prerequisites have long lead times.

### 3.1 D-U-N-S number (organisations, up to 28 days)

A D-U-N-S number is mandatory when registering as an **organisation**. It is free
from Dun & Bradstreet, but obtaining one "can take up to 28 days", so start here.

- [ ] Check whether 3827992 Canada Inc. already has a D-U-N-S number (D&B search)
- [ ] If not, request one at <https://www.dnb.com/en-us/smb/duns.html>
- [ ] Record the number and the exact legal name/address it is registered under — the
      identity documents must match it

### 3.2 Verified website (Google Search Console)

The organisation's website must be **verified in Google Search Console**. We control
`gnitoapp.com` on GitHub Pages, so the DNS TXT method is the reliable one:

- [ ] In Search Console, add a **Domain** property for `gnitoapp.com`
- [ ] Add the TXT record Google gives you to the domain's DNS
- [ ] Verify, and keep the property in place (it is also useful for sitemap monitoring)

### 3.3 Documents for the person who signs up

For a Canadian organisation, prepare scanned copies of:

- [ ] Government-issued **photo ID** of the person completing verification
- [ ] **Proof of address** for that person (utility bill, bank/credit-card statement,
      insurance statement — issued in the last few months, showing name and address)
- [ ] **Incorporation / registration document** for 3827992 Canada Inc. showing the
      legal entity name (Google's published examples are US-specific: IRS letters,
      state certificate of incorporation, SEC filings, business credit reports — the
      list for Canada will differ, so have the federal/provincial incorporation
      certificate ready)
- [ ] A **private email address and phone number** you can receive a one-time password
      on (these are verified with OTP)

Source: [full distribution requirements](https://developer.android.com/developer-verification/guides/full-distribution).

### 3.4 The Google Account question

The ADC signs you up with a **Google Account**. Use a business-owned account you
control (e.g. `accounts@gnitoapp.com`), not a personal one, and not the account that
was terminated on Play.

> Honest caveat: Google documents that the ADC is separate from Play and does not
> require a Play account. It does **not** document how a terminated Play identity is
> treated during ADC identity verification. Do not attempt to disguise the identity —
> the organisation and its documents are the same. If verification is rejected,
> contact ADC support (<https://support.google.com/android-developer-console>) and
> explain the history rather than opening new accounts.

---

## 4. Create the account and verify the organisation

1. Go to **<https://android.google.com/developerconsole>** and sign in with the
   business Google Account.
2. Choose **Full distribution**.
3. Pay the **US$25** one-time fee. Google has said it is expanding payment methods;
   if the card form rejects a Canadian card, check the FAQ before assuming a problem
   with the card.
4. Enter the **legal name and address** exactly as they appear on the incorporation
   document, and the D-U-N-S number.
5. Upload the photo ID, proof of address and organisation document.
6. Verify the email address and phone number with the OTPs Google sends.
7. Wait for the identity review. The console reports the status; Google emails the
   decision. There is **no published SLA** — plan for days, not hours.

Sources: [Register on Android Developer Console](https://developer.android.com/developer-verification/guides/android-developer-console),
[FAQ](https://developer.android.com/developer-verification/guides/faq).

---

## 5. Register each app (package name + signing key)

Registration is **per package name**, and it binds the package to the SHA-256
**fingerprint of the signing certificate**. The console's **Package names** tab is
where this happens.

For each app:

1. **Package name** — the exact `applicationId` of the flavour we ship:

   | App | Package name (published flavour) | Huawei flavour |
   | --- | --- | --- |
   | Units2Units | `com.gnitoapp.units2units_gms` | `com.gnitoapp.units2unitshms` |
   | Force Workout Helper | `com.gnitoapp.forceworkouthelper_gms` | `com.gnitoapp.forceworkouthelper_hms` |
   | Romanitaire | `com.gnitoapp.romanitaire_gms` | `com.gnitoapp.romanitaire_hms` |

   Register the `_gms` names now — those are the APKs on the site. Register the Huawei
   names only if those flavours are ever distributed. (Note the odd
   `units2unitshms` spelling: it is what the app actually uses, and package names are
   permanent.)

2. **SHA-256 certificate fingerprint** of the signing key — not the APK's hash. Get it
   from the keystore (default password prompt) or from a built APK:

   ```bash
   keytool -list -v -keystore ~/keys/<product>-release.jks | grep -A1 "Certificate fingerprints"
   apksigner verify --print-certs <app>.apk | grep "certificate SHA-256"
   ```

   Or from this repo, which publishes what is currently shipped:

   ```bash
   python3 -c "import json;[print(k, v['signerCertSha256']) for k,v in json.load(open('data/apk_checksums.json')).items()]"
   ```

3. **Prove ownership** — for a package name that already exists in the wild (all
   three of ours do), the console asks you to sign an APK with the private key and
   upload it, using a **snippet it gives you to place in the APK's asset folder**.
   This is the step that proves the key, not just the name.
4. Status goes **In review** → **Registered** (email + console). Until it is
   `Registered`, treat the app as unregistered.

Sources: [ADC registration guide](https://developer.android.com/developer-verification/guides/android-developer-console),
[FAQ](https://developer.android.com/developer-verification/guides/faq).

### Multiple keys and the re-key we are doing now

The ADC supports **several verified keys per package name** — this is exactly what a
key rotation needs. Order of operations, matching `docs/KEY-CHANGE.md`:

- [ ] Generate the new key and sign the release build
- [ ] Register the **new** certificate against the package (old one stays registered)
- [ ] Publish the APK with the key-change notice and `--allow-key-change`
- [ ] After users have migrated, remove the old certificate from the package entry
- [ ] If a package name were ever changed, it would need a fresh registration; ours
      are not changing

Source: [FAQ — multiple signing keys](https://developer.android.com/developer-verification/guides/faq).

### "Your key is not eligible to claim this package name"

Package names are allocated by install history when several developers use the same
name: the key with **>50% of known installs** wins; otherwise any key with **≥50
installs** may register; otherwise it is first-come, first-served. Our package names
are GnitoApp-specific, so this should not apply — but if the console says the key is
ineligible, the options are a different package name or a manual request with proof of
ownership and justification.

---

## 6. Verify that it worked

- [ ] The Packages tab shows **Registered** for each package (Play Console would show
      the same on its Android developer verification page; we do not have one)
- [ ] On a certified device in a launch country (or via the advanced flow), install
      the APK from `https://gnitoapp.com/<product>/` and confirm it installs without
      the "unverified developer" path
- [ ] ADB install still works regardless — use it for local testing
- [ ] Keep the registration status alongside the release notes for each app

---

## 7. Keeping it true

- Registration is bound to the **package name + key**. Every key change needs the new
  certificate added (see §5), and every package name change needs a new registration.
- Keep the keystore backups and the ADC account credentials in the same vault entry as
  the keys — losing either means the app cannot be updated (see `docs/KEY-CHANGE.md`).
- Google changes this programme frequently. Re-read the
  [FAQ](https://developer.android.com/developer-verification/guides/faq) and the
  [verification page](https://developer.android.com/developer-verification) before
  each release cycle, and update this file when they change.
- Automation exists if the manual flow becomes tedious: the **Android Developer ID
  Status API** (check eligibility/status) and the **Android Developer Console API**
  (register packages and keys from CI). Not needed for three apps.

---

## 8. Where our apps stand

| App | Package name | Registered? | Notes |
| --- | --- | --- | --- |
| Units2Units | `com.gnitoapp.units2units_gms` | no | awaiting the new signing key |
| Force Workout Helper | `com.gnitoapp.forceworkouthelper_gms` | no | awaiting the new signing key |
| Romanitaire | `com.gnitoapp.romanitaire_gms` | no | awaiting the new signing key |

The three keys are being replaced first (`force-workout-helper#7`, `units2units#1`,
`romanitaire#2`), so registration happens **once**, against the final keys, rather
than twice.

---

## 9. Link collection

- Verification overview: <https://developer.android.com/developer-verification>
- ADC registration guide: <https://developer.android.com/developer-verification/guides/android-developer-console>
- Full distribution account: <https://developer.android.com/developer-verification/guides/full-distribution>
- Limited distribution account: <https://developer.android.com/developer-verification/guides/limited-distribution>
- FAQ (fees, IDs, signing keys): <https://developer.android.com/developer-verification/guides/faq>
- Console: <https://android.google.com/developerconsole>
- Console help: <https://support.google.com/android-developer-console>
- Play-side equivalent (not our path): <https://developer.android.com/developer-verification/guides/google-play-console>

This is an operational runbook, not legal advice.
