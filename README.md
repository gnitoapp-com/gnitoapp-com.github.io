# gnitoapp.com

Source for <https://gnitoapp.com> — the product pages and Android APK downloads for
Units2Units, Force Workout Helper and Romanitaire, plus the privacy, terms and
support pages.

Static site built with **Hugo** (extended) and the **Docsy** theme module, deployed
to **GitHub Pages** by GitHub Actions on every push to `main`.

## Working on it

```bash
npm ci                  # pinned Hugo, Dart Sass, validation tooling
./scripts/hugo server   # dev server on :1313
npm run build:production # the deploy build (also runs the link check)
npm run verify          # APK integrity, spelling, HTML, links
```

There is no system-wide `hugo` requirement: `scripts/hugo` runs the version pinned
in `package.json` with the toolchain it needs. See `AGENTS.md` for the full command
set, the invariants that must not be broken, and the definition of done.

## Layout

| Path | Contents |
| --- | --- |
| `content/en/` | Pages: home, product pages, privacy, terms, support |
| `data/products/` | Per-product facts (platforms, tagline, badges, screenshots) that drive the product layout |
| `data/apk_checksums.json` | Generated integrity data: SHA-256, size and signing-certificate fingerprint per APK |
| `static/<product>/` | The current APK, `SHA256SUMS`, screenshots and logo for each product |
| `layouts/` | Layout and partial overrides on top of Docsy |
| `assets/scss/` | Project variables and rules |
| `scripts/` | Integrity checks, link checker, deploy smoke test, Hugo wrapper |
| `docs/` | Maintenance audit and the signing-key change procedure |

## Deploying

Push to `main`. The workflow builds the site with `npm ci && npm run build:production`,
verifies APK integrity, links and HTML, uploads the Pages artifact and smoke-tests the
deployed site. The deployment job runs only for `main`.

## Documentation for maintainers

- `AGENTS.md` — operating manual: commands, invariants, quality gates, working agreement.
- `docs/MAINTENANCE.md` — audit findings, what is fixed, and the remaining backlog.
- `docs/KEY-CHANGE.md` — procedure for changing an app's signing key.
- `docs/ANDROID-DEVELOPER-VERIFICATION.md` — how to register as an Android developer
  (Android Developer Console, not Play) and register each app's package name and key.

## Licence

Proprietary; all rights reserved. See `LICENSE`. Third-party dependencies keep their
own licences (Docsy and Hugo are Apache-2.0, Bootstrap MIT, Font Awesome as noted in
`LICENSE`).
