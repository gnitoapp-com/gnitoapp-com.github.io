# Maintenance audit — gnitoapp.com

Audit date: 2026-10-29. Baseline commit: `5efb80c` (`main`, deployed 2026-07-27).
Everything below was verified by reading the repo, building it locally, and comparing the
artifact with the live site. Each finding states its evidence and the fix; findings are referenced
as `D<n>` from `AGENTS.md` and from commit messages.

**Status (2026-10-30).** Every finding below is addressed on the working branch
`major-enhancements` (more than 50 commits ahead of `main`, pushed). **`main` and the live site are
deliberately still at the baseline** — advancing `main` is the owner's call (see
`AGENTS.md`, "Hard rule: `main` is off-limits"), and until it moves the Dependabot pull requests
targeting `main` stay open and valid. Remaining work is in the app repositories, not here.

Severity: **P0** breaks correct output or the delivery contract · **P1** will break or bite
soon · **P2** maintainability/quality debt · **P3** polish.

---

## Snapshot

Measured 2026-10-29 at baseline `5efb80c`; the "now" column reflects the fixes below.

| Metric | At audit | Now |
| --- | --- | --- |
| Pages built | 19 | 13 (search, taxonomies and print output removed) |
| Static files | 59 | 33 |
| `public/` size | 530 MB | 247 MB |
| `static/` size | 528 MB (509 MB APKs, 21 MB screenshots) | 245 MB (APKs only; screenshots moved to `assets/`) |
| Screenshot weight served | 21 MB of PNG | 592 KB of WebP (230/460 px, `srcset`) |
| APKs with no page linking to them | 3 files, 264 MB | 0 |
| `.git` size | 305 MB | 305 MB (deleting files does not shrink history) |
| Product pages | 130 / 139 / 112 lines, 43 / 47 / 44 inline `style=` attributes | front matter + Markdown, rendered from `data/products/*.yaml`; 0 inline styles |
| Duplicated version strings | 4 per product, unverified | 1 typed (`version.json`); the rest generated and CI-checked |
| Build time | ~60 s cold, ~2 s warm | ~15 s cold, ~2–3 s warm (module cache + image processing) |
| Hugo build warnings | 3 (2 deprecations + 1 Docsy render hook) | 0 |
| Open Dependabot PRs | 3 (all stale npm bumps) | 3, kept deliberately: they target `main`, which is behind the branch |
| Published APK integrity data | none | SHA-256 + size + signing-certificate fingerprint per APK, gated in CI |
| Brand assets | Docsy's favicons, no navbar logo, no `og:image` | own favicon/manifest/PWA set, navbar mark, per-page social cards |

## Resolved

| Finding | Status | Commit |
| --- | --- | --- |
| D26 — code blocks unreadable on the support page, legal pages missing their wrapper | fixed: `markup.highlight.noClasses: false` + `@import 'td/code-dark'`; plain pages render through Docsy's `_td-content` wrapper | `147b47e` |
| D16 — no verification gates (link check was a stub) | fixed: `scripts/check-links.sh` (internal links + anchors) in `postbuild:production`, cspell, html-validate, `npm audit --omit=dev`, and a post-deploy smoke test in the deploy job | `e0144db` |
| D22 — placeholder cspell dictionary | fixed: real product/domain dictionary; it immediately caught an `ifetime` typo | `e0144db` |
| D23 — feedback widget posting to an unconfigured Google Analytics | fixed: the `feedback` block was removed | `441455d` |
| D19 remainder — HTTP security headers | decided: accepted and documented; Pages cannot set headers, a `<meta>` CSP would be symbolic here. Cloudflare in front is the path if it ever matters | `a559317` |
| D25 — signing identities | decided: re-key all three apps (FWH included because its keystore is in git); execution tracked in the app repos | `856152c` |
| D14 — screenshots were unoptimised PNGs served verbatim | fixed: sources moved to `assets/screenshots/`, Hugo renders 230/460 px WebP with `srcset` + width/height; published weight 21 MB → **592 KB** | `f5fc309` |
| D10 — theme branding: Docsy favicons, no navbar logo, no social image | fixed: favicon set + manifest + apple-touch generated from the master logo, navbar mark, per-product 1200×630 social cards with a site-wide fallback | `5f32de4` |
| D12 — privacy policy contradicted the apps and had no date | fixed: rewritten against what the shipped APKs actually do (Sentry crash reports, RevenueCat/Stripe purchases, version check, currency API, GitHub Pages logs), dated, Chinese sibling kept per owner decision | `b80326f` |
| D11 — product pages were raw inline-styled HTML with a 4-way version duplication | fixed: `data/products/*.yaml` + one layout + partials, version from generated data, zero inline styles, semantic tables | `7860279` |
| D1 — published URLs were `http://`, no canonical | fixed: canonical hook + `hugo.yaml` is the only baseURL source, `robots.txt` advertises the sitemap | `63de339` |
| D9 — 264 MB of unreferenced APKs | fixed: three superseded APKs deleted (pages unchanged, links verified) | `2d0b3e2` |
| Deploy from a non-`main` ref (hardening, noted under D18) | fixed: deploy job is gated to `github.ref == 'refs/heads/main'`; a branch dispatch now builds without publishing | `19b1cd1` |
| D3 — no lockfile | fixed: `package-lock.json` tracked, Node pinned to 22, `npm ci` verified from a clean tree | `7d119c5` |
| D2 — Hugo version skew (CI 0.145 vs npm 0.161) | fixed: CI now runs `npm ci && npm run build:production`, so the npm pin is the only Hugo version; `HUGO_VERSION` removed from the workflow | `e5740b9` |
| D17 — no caching, floating tool installs | fixed: npm + Hugo-module caches (15 s cold, 1.4 s warm), no `npm i -D …`, `fetch-depth: 1`; `enableGitInfo` deliberately left off (see D17) | `e5740b9` |
| Hugo deprecations (`languageName`, `LanguageDirection`) in our config/template | fixed; the Docsy v0.11 warnings disappeared with the theme upgrade (D15), so the build is warning-free | `2ca1c92`, `2fbf3d1` |
| D18 — Dependabot scope and PR noise | partly fixed: `github-actions` + `gomod` watched, weekly, one PR per ecosystem. Owner decision 2026-10-30: leave the PRs open while `main` stays behind the branch — they are valid against `main` | `1ab11e1`, `83da277` |
| D5 — README/CONTRIBUTING/LICENSE were Docsy template text | fixed: real README, CONTRIBUTING deleted, LICENSE replaced with an all-rights-reserved notice (owner decision) that lists third-party licences | `441455d` |
| D6 — repo identity was the Docsy example's | fixed: `package.json` name/description/repository/homepage/author/licence, `go.mod` module path, go directive 1.18 | `441455d` |
| D7 — dead scaffolding | fixed: `hugo-disabled.toml`, `config.yaml`, `docsy.work*`, `netlify.toml`, `Dockerfile`, `docker-compose.yaml` deleted with their npm scripts | `441455d` |
| D8 — `/search/` published with no backend | fixed: page deleted (enable Docsy offline search later if wanted) | `441455d` |
| D13 — empty taxonomy pages and dead params | fixed: `disableKinds: [taxonomy]`, taxonomy/version/print/feedback/reading-time config removed | `441455d` |
| D4 — stale `baseof.html` fork, dark mode after `</body>` | fixed: template deleted, dark mode set in the head hook, fixed-navbar offset restored in project SCSS | `4169d95` |
| D15 — Docsy v0.11 vs v0.18 | fixed: Docsy v0.18.0 at `github.com/docsy/docsy/theme`, Bootstrap/Font Awesome via `hugo mod npm pack`, Dart Sass via `sass-embedded` + postinstall shim, zero build warnings | `2fbf3d1` |
| D2 follow-up — Hugo 0.161.1 vs latest | fixed: Hugo 0.169.0, `imaging.quality` migrated to per-format keys | `2fbf3d1` |
| D19 — no download integrity data | fixed for integrity: `scripts/apk-checksums.sh` derives SHA-256/size/certificate, `SHA256SUMS` per product, a collapsed block on each page, and a CI gate. HTTP security headers remain out of scope on Pages | `cca3069` |

## Open work

**This repository has no open issues** — #76 to #83 are closed, each with the evidence in its
thread. What remains lives in the app repositories:

| Repo | Issue | Work |
| --- | --- | --- |
| force-workout-helper | [#7](https://github.com/gnitoapp-com/force-workout-helper/issues/7) | Replace the signing key (new 4096-bit key, untrack the committed keystore, hard-fail the debug fallback, register the package) |
| units2units | [#1](https://github.com/gnitoapp-com/units2units/issues/1) | Generate a new signing key (the old one is unlocatable), untrack the plaintext credential file, register |
| romanitaire | [#2](https://github.com/gnitoapp-com/romanitaire/issues/2) | Replace the Android debug key with a release key, hard-fail the debug fallback, publish with the uninstall notice, register |
| romanitaire | [#3](https://github.com/gnitoapp-com/romanitaire/issues/3) | In-app privacy link is a 404 (`/privacy_policy/` → `/privacy/`) |
| force-workout-helper | [#8](https://github.com/gnitoapp-com/force-workout-helper/issues/8) | Its in-app policy is a second, stale copy that contradicts the app |

The site side of the re-key is ready: the `notice:` text is pre-written (commented) in
`data/products/*.yaml`, `--allow-key-change` is the publish gate, and `docs/KEY-CHANGE.md` has the
procedure including the `keytool` command.

Not in the issue tracker, by choice: **D21** (monitoring/performance budget) is optional polish, and
**D20** was dropped by the owner — the home page stays as-is.

---

## P0 — correctness

### D1. Every published URL was `http://`, not `https://` — **resolved in `63de339`**
The deploy passed `--baseURL "${{ steps.pages.outputs.base_url }}/"`; on GitHub Pages with a
custom domain that output is `http://gnitoapp.com`, so `og:url` and `sitemap.xml` shipped insecure
absolute URLs while Hugo would have used the correct `baseURL` from `hugo.yaml`. No
`<link rel="canonical">` was emitted at all.

Evidence: `curl -s https://gnitoapp.com/units2units/ | grep og:url` → `http://gnitoapp.com/units2units/`;
`curl -s https://gnitoapp.com/sitemap.xml | head` → every `<loc>` was `http://`.

Fix applied: the `--baseURL` override is gone (baseURL now comes only from `hugo.yaml`),
`layouts/partials/hooks/head-end.html` emits `<link rel="canonical" href="{{ .Permalink }}">`
(skipped for the 404 page and for Docsy's `print` output, which canonicalises itself), and
`layouts/robots.txt` advertises the sitemap. Verified in the build: one canonical inside `<head>` on
all 12 pages, `og:url` https, sitemap `<loc>` https, `Sitemap: https://gnitoapp.com/sitemap.xml`.

Still to confirm on the first deploy of `main`: production flipped —
`curl -s https://gnitoapp.com/units2units/ | grep -o 'og:url" content="[^"]*"'` must say `https`.

### D2. Three different Hugo versions in play — **resolved in `e5740b9`**
`hugo.yaml` pins `HUGO_VERSION: 0.145.0` for CI; `package.json` pins `hugo-extended@0.161.1`
which is what `npm run build` uses; Docsy is pinned at v0.11.0 while Hugo upstream is 0.169.0.
The 0.161.1 build already warns:

```
WARN deprecated: project config key languages.en.languageName ... use languages.en.label
WARN deprecated: .Language.LanguageDirection ... use .Language.Direction
WARN skipping template file ".../docsy@v0.11.0/layouts/_default/_markup/td-render-heading.html": unrecognized render hook template
```

Meaning: the local build is not the deploy build, the deploy build is 16 releases behind, and the
theme is 7 minor versions behind. Fix: make CI use the npm-pinned Hugo (`npm ci && npm run
build:production`) so there is exactly one version, then bump `hugo-extended` and fix the
deprecations (`languages.en.label`, `.Language.Direction` in the baseof override). Handle the Docsy
upgrade as its own task with visual checks (D15).

### D3. Builds are not reproducible (no lockfile) — **resolved in `7d119c5`**
`.gitignore` excludes `package-lock.json`; the workflow does
`[[ -f package-lock.json || -f npm-shrinkwrap.json ]] && npm ci || true`, which silently does
nothing, then installs floating versions with `npm i -D postcss postcss-cli autoprefixer`.
Dependabot therefore edits `package.json` ranges with no resolved tree. Fix: delete the ignore
line, commit the lockfile, use `npm ci` unconditionally, and delete the ad-hoc install step.

### D4. The local `baseof.html` is a stale fork of the theme, and dark mode is a hack — **resolved in `4169d95`**
`layouts/_default/baseof.html` is a copy of Docsy 0.11's baseof with an extra
`<script defer>document.documentElement.setAttribute("data-bs-theme","dark")</script>` placed
**after `</body>`** (and no trailing newline). It has already drifted: the theme ships
`<div class="container-fluid td-default td-outer">` while the copy has `td-main`, so the wrapper
carries `td-main` twice. Any theme upgrade will silently keep this stale wrapper, and the script
runs after first paint (flash of light theme) and cannot be toggled off.

Fix: delete the override; set the theme before paint with a small `head-end` hook partial, or use
Docsy's own light/dark menu (`params.ui.showLightDarkModeMenu`) and make dark the default. Also
replace `languages.en.languageName` with `label` in `hugo.yaml`, and drop
`ui.feedback`/`readingtime`/`version_menu` params nothing uses.

---

## P1 — will bite soon

### D5. README, CONTRIBUTING and LICENSE still describe the Google Docsy template — **resolved in `441455d`**
`README.md` is the Docsy example readme (example.docsy.dev, Goldydocs, Netlify dashboards, "use
this template"); `CONTRIBUTING.md` requires a Google CLA and Google's code of conduct. `LICENSE`
is Apache-2.0 inherited from the template while all content, screenshots, branding and APKs are
the owner's. Fix: replace with a real README (what the site is, how to build/deploy, link to
`AGENTS.md` and this file); delete CONTRIBUTING.md (the workflow is direct local commits) or
replace it with the real contribution rule; decide the license deliberately — keep Apache-2.0
for code if desired, but the assets are not Apache-2.0.

### D6. Repo identity is still the template's — **resolved in `441455d`**
`go.mod` declares `module github.com/google/docsy-example`; `package.json` is
`docsy-example-site` version 0.10.0 with Docsy's description, repository, homepage, bugs and
author fields; `package.json` `spelling` is Docsy's cSpell ignore list. Fix: set
`module github.com/gnitoapp-com/gnitoapp-com.github.io`, name the package after the site, drop or
correct the metadata, then re-run the build and `hugo mod` commands.

### D7. Dead template scaffolding — **resolved in `441455d`**
`hugo-disabled.toml` — a full stale TOML copy of the site config with `example.docsy.dev` and
`Goldydocs` values; `config.yaml` — Docsy's version guard, harmless but redundant; `docsy.work`
+ empty `docsy.work.sum` — local Docsy workspace pointing at a sibling clone that does not exist;
`netlify.toml` — Netlify build config for a site that deploys to Pages only; `Dockerfile` +
`docker-compose.yaml` — build `docsy/docsy-example` without Go, so the Docsy module cannot even be
fetched. Fix: delete all of them (or, if a container workflow is wanted, one working
`Dockerfile` based on `floryn90/hugo:ext-alpine` with Go installed, and document it).

### D8. `/search/` is published but cannot work — **resolved in `441455d`**
`content/en/search.md` exists; `params.gcs_engine_id` is commented out and `offlineSearch: false`
in `hugo.yaml`, so the page renders without a search backend (Docsy only emits the search box
when one is configured). Fix: either enable Docsy offline search (`offlineSearch: true`) or delete
the page.

### D9. 264 MB of static APKs nothing links to — **resolved in `2d0b3e2`**
Unreferenced files: `forceworkouthelper_v1_3_4.apk` (84 MB), `units2units_v1_1_0.apk` (90 MB),
`units2units_v1_1_1.apk` (90 MB). They account for half the published site and every deploy
artifact upload, and every clone of the repo. GitHub Pages limits (1 GB site, 100 GB/month soft
bandwidth) plus the 305 MB `.git` make this the single biggest cost. Fix: delete the three
orphans in one commit; adopt a policy of keeping exactly one APK per product (superseded APKs go
away with the release). Consider `git-lfs`/release assets only if the owner wants APK history;
note that removing files does not shrink `.git` — that needs history rewriting and coordination.

### D10. Brand identity is Docsy's, not GnitoApp's — **resolved in `5f32de4`**
`public/favicons/*` are the theme's defaults (Google Docsy icon), the navbar renders no logo
(`params.ui.navbar_logo: true` but no `assets/icons/logo.svg`), and no page sets an `og:image`, so
link previews on Bluesky/App Store listings have no artwork. Fix: add real `static/favicons/*`
(from the product logo, or a GnitoApp mark), add `assets/icons/logo.svg`, and set a per-page
`images:` front-matter value (product logo/screenshot) so Docsy emits `og:image` +
`twitter:image`. Also add `apple-touch-icon` and `site.webmanifest` if the site should be
installable.

### D11. Product pages defeat the theme (and dark mode) — **resolved in `7860279`**
Each product page is 110–140 lines of raw HTML with 43–47 inline `style=` attributes, a wrapper
`div` that hard-codes `background-color:#ffffff; color:#000000`, non-semantic tables (a second
`<thead>` mid-table, no `scope` attributes), and 30-property style strings repeated for every
cell. Effects: on a forced-dark site these pages are bright white slabs; Docsy's typography,
print styles, `prefers-color-scheme` and hover/focus states never apply; content headings sit
inside `<div>`s so the page TOC and heading anchors are gone; no structured data. Fix (largest
win on the site): move per-product facts into `data/products/<product>.yaml` (name, tagline,
category, license, version, apk, store URL, languages, badges, feature groups), add one
`layouts/partials/product-page.html`, and drive all three pages from data. Versions can then be
read from `static/<product>/version.json` via `os.ReadFile` at build time, or — better — the data
file becomes the source of truth and `version.json` is generated in the build, eliminating the
4-way duplication in `AGENTS.md` invariant 1.

### D12. Privacy policy contradicts the product claims, and has no date — **resolved in `b80326f`**

The old policy claimed "cookies, web beacons and other tracking technologies" and third-party
account linking, while every product page says "No Ads / No Trackers / No Login" and no app has
accounts. It had no date and no retention/contact specifics.

What shipped: the policy was rewritten against behaviour verified in the shipped APKs and app
sources — all three bundle Sentry (`sentry_flutter` via `catcher_2`, `sendDefaultPii` at its
default) for crash diagnostics; Units2Units sells its Pro upgrade through RevenueCat (Apple on
iOS, Stripe web paywalls on Android); every app polls gnitoapp.com for updates; Units2Units fetches
currency rates from open.er-api.com; the site sets no cookies and runs no analytics, while GitHub
Pages keeps server logs. The page now states those four outbound flows, what stays on the device,
retention per party, PIPEDA/GDPR rights, a one-line children statement, and **Last updated:
30 October 2026**. Chinese remains a sibling page (`privacy_zh.md`, translated to match, linking
back to `/privacy/`).

Follow-ups, tracked in the app repos: Romanitaire's in-app link points at a 404
(`/privacy_policy/` → `romanitaire#3`) and Force Workout Helper ships a second, stale policy
(`force-workouthelper#8`). In App Store Connect, the App Privacy answers must match this text —
"Purchases" for Units2Units, "Diagnostics" for all three, no tracking — that is a store-console
task, not a page edit.

### D13. Empty taxonomy pages and dead template params — **resolved in `441455d`**
`taxonomies` are enabled and Docsy shows tag/category clouds, but no page uses `tags:` or
`categories:`, so `/tags/` and `/categories/` are empty pages in the sitemap. Fix: set
`disableKinds: [taxonomy, taxonomyTerm]` (the line is already there, commented) or actually
tag posts if a news/blog section is planned. Same sweep: `permalinks.blog`,
`params.taxonomy.*`, `params.versions`, `params.version*`, `archived_version`, `readingtime`,
`prism_syntax_highlighting`, `outputs.section: print` — none are used by this content set.

### D14. Screenshots are unoptimized PNGs in `static/` — **resolved in `f5fc309`**
21 MB of screenshots, individually up to 3.7 MB, copied verbatim (Hugo does not process
`static/`), no `width`/`height` attributes → cumulative layout shift on the pages that sell the
apps, mostly to mobile users. Fix: move to page bundles under `assets/` and use Hugo image
processing (`fill 460x`, `webp`), or pre-optimize with `oxipng`/`cwebp` at ≤ 300 KB and add
dimensions. Target: < 2 MB total.

### D15. Docsy v0.11.0 vs upstream v0.18.0 — **resolved in `2fbf3d1`**
Seven minor versions behind, and the local baseof override (D4) is based on 0.11. Upgrading will
change markup/CSS and probably config keys; treat it as a project: bump `go.mod`, refresh the Hugo
pin, remove the baseof override first, then diff `public/` before/after for the public pages.
Do not attempt it in the same commit as content or release work.

Done (2026-10-29): Docsy v0.18.0 and Hugo 0.169.0 land together with the module-path change,
`hugo mod npm pack` for Bootstrap/Font Awesome, and the Dart Sass toolchain. Two visible
consequences are documented in the commit and on #79: the dark background is a shade darker
(theme palette change) and Docsy 0.16 stopped shipping default favicons — the site now supplies its
own (`5f32de4`).

The upgrade also added a second local override to re-diff each time: `layouts/partials/navbar.html`
(theme template + dropdown support for menu entries with children, added for #87). Treat it like
`baseof.html` used to be — diff it against the theme before/after any Docsy bump, or it silently
freezes old navbar markup.

---

## P2 — delivery and quality gates

### D16. No verification gates at all — **resolved in `e0144db`**
`npm run check:links` prints `IMPLEMENTATION PENDING`; there is no HTML validation, no
accessibility check, no spell check (despite `.cspell.yml`), and no post-deploy smoke test.
(The APK integrity gate from D19 now exists and is the model for these: a cheap, deterministic
check that fails the deploy.)
Fix: add a `scripts/check-links.sh` (lychee or htmltest over `public/`, ignoring the external
App Store URLs or checking them with retries), add `cspell` over `content/` with the real
word list, and make the deploy job fail on broken internal links. Add a smoke step after deploy:
`curl -fsS https://gnitoapp.com/units2units/ | grep -q 'Download APK'` plus one check that the
`og:url` is `https://`.

### D17. The workflow does no caching and installs floating tools — **resolved in `e5740b9`**
No npm or Hugo-module cache → every run re-downloads Docsy (~60 s); `npm i -D postcss postcss-cli
autoprefixer` ignores `package.json` pins. Fix: `actions/setup-node` with `cache: npm`, cache
`${{ runner.temp }}/hugo_cache` keyed on `go.sum`, and use `npm ci` (see D3). Also set
`enableGitInfo: true` (the checkout already uses `fetch-depth: 0`) to get `lastmod` in the
sitemap, and drop the unused `snap install dart-sass` step once CI uses the npm Hugo.

### D18. Dependabot PRs conflict with the working model — **policy settled 2026-10-30**

Original problem: only npm was watched, daily, with 10 open slots, for an owner who does not use
pull requests.

Applied (`1ab11e1`, `83da277`): `github-actions` and `gomod` ecosystems added, weekly schedule,
`open-pull-requests-limit: 1` per ecosystem, `deps`/`ci` commit-message prefixes, and the
notification-only policy written into `.github/dependabot.yml`.

**Owner decision 2026-10-30:** leave the open Dependabot pull requests alone while `main` stays
behind the working branch — they are valid *against `main`*, which still pins the old versions.
`#86` (`deploy-pages` v5) is already applied on the branch (`6ea54a3`) but must not be closed
until `main` moves. Once `main` advances, the remaining PRs become redundant and should be closed
with a note pointing at the commits that superseded them.

### D19. Download security — **integrity part resolved in `cca3069`**
APKs are served straight from GitHub Pages (`application/octet-stream`) with no published
integrity data, while the pages tell users to bypass Google Play Protect. Signing identity +
version + hash is what makes "Install anyway" a defensible instruction.

Applied: `scripts/apk-checksums.sh` computes the APK's SHA-256, byte size, version, signing
certificate digest/DN and (via `aapt2`) package/`versionCode`/`versionName`; it writes a
sha256sum-compatible `SHA256SUMS` per product and `data/apk_checksums.json`, which
`layouts/partials/apk-verify.html` renders as a collapsed "Verify this APK" block. The
workflow's `Verify APK integrity data` step runs `--check` (plain Python) before building, so a
stale checksum, a renamed APK, a mismatched `version.json`/`versionName`, or a page still linking
the previous file fails the deploy.

Headers — **decided 2026-10-30: accept the limitation, documented rather than half-implemented.**
GitHub Pages cannot set response headers, so HSTS, `X-Content-Type-Options`, `X-Frame-Options` /
`frame-ancestors` and a real CSP are unavailable. A `<meta>` CSP is technically possible now that
#76 removed the inline styles, but it would be largely symbolic here: the content is static with no
server-side input, the theme still emits ~35 inline `style` attributes (the navbar logo SVG) forcing
`style-src 'unsafe-inline'`, and `<meta>` cannot express `frame-ancestors` or HSTS at all. If headers
become a requirement, front the site with Cloudflare and set them there — nothing in the repo blocks
that.

---

### D24. `npm audit` reports high-severity advisories in a dev-only tool
`hugo-extended` depends on `adm-zip@^0.5.17` to unpack the Hugo binary at install time, and
`adm-zip <= 0.6.0` carries several high advisories (zip-slip, decompression bomb, memory abuse).
Reach: install-time only, on a build machine, against a GitHub release artifact — never in the
shipped site, and `npm audit --omit=dev` reports 0 vulnerabilities. **Do not run
`npm audit fix --force`**: npm's suggested fix downgrades `hugo-extended` to 0.152.2, i.e. it
trades a real build-version regression for an advisory with no user exposure. `hugo-extended`
0.166.0 still pins the same range. Revisit when upstream bumps `adm-zip`, and keep the production
audit (`--omit=dev`) in the quality gate instead of the full audit.

### D25. Signing identities are inconsistent, and release builds silently fall back to debug — **decision: re-key all three (2026-10-30)**
Read from the published artifacts with `apksigner verify --print-certs`, and from the app repos
on 2026-10-29:

| APK | Signing certificate | Key available? |
| --- | --- | --- |
| Force Workout Helper 1.3.6 | `CN=Dewald Pretorius, OU=gnitoapp.com, O=gnitoapp.com, L=moncton, ST=nb, C=ca` | yes — verified on disk, matches the published `55bd1c5b…4aa3` |
| Units2Units 1.2.0 | `CN=Unknown, OU=Unknown, …` (all fields `Unknown`) | **not on this machine** |
| Romanitaire 1.0.8 | `C=US, O=Android, CN=Android Debug` | debug keystore only |

Root cause of the Romanitaire case: all three app repos use the Flutter template release block,
which falls back to the debug signing config when `android/key.properties` is missing:

```kotlin
signingConfig = if (keystorePropertiesFile.exists()) signingConfigs.getByName("release")
                else signingConfigs.getByName("debug")
```

Any machine without `key.properties` therefore produces a *release* APK signed with a throwaway
key, with no error. Romanitaire 1.0.8 was built that way. The same fallback is still armed in
`force-workout-helper` and `units2units` — replace it with a hard failure, e.g.
`require(keystorePropertiesFile.exists())`.

Two further problems in the Force Workout Helper repo (private, `gnitoapp-com/force-workout-helper`):

- **The PKCS12 keystore is committed** (`android/upload-keystore.jks`, alias `upload`, RSA 2048,
  valid to 2052-08-21) together with `android/key.properties`, which holds `storePassword` and
  `keyPassword` in clear text (they are identical). Anyone with repo read access, any CI checkout,
  or one accidental visibility change owns the app's signing identity for good. Untrack both
  (`git rm --cached`, then `.gitignore`), rotate the store/key password (`keytool -storepasswd`
  leaves the certificate unchanged — re-verify the fingerprint afterwards), keep the repo private,
  and purge history with `git filter-repo` before adding collaborators or ever making it public.
  Keep the key itself: rotating the key would break in-place updates.
- **2048-bit RSA** is acceptable (Play requires ≥2048). Do not "upgrade" it — that means a new key.

**Decision (2026-10-30):** replace the key for all three apps rather than repairing the
existing identities, while the install base is effectively zero. Force Workout Helper is
included because rotating is the only way to neutralise a keystore that lives in git.
Execution is tracked in the app repos (`force-workout-helper#7`, `units2units#1`,
`romanitaire#2`); the site side is ready — the uninstall/data-loss `notice:` text is
pre-written (commented) in `data/products/*.yaml`, `--allow-key-change` is the publish gate,
and `docs/KEY-CHANGE.md` has the full procedure including the `keytool` command.

What to do, in order:

1. **Units2Units** — find the keystore that produces `cfb9df2f…be38`. If found, back it up and keep
   it: a stable anonymous identity beats a pretty one that breaks updates. If lost, the next
   release needs a new key plus a one-time "uninstall and reinstall" note on the page.
2. **Romanitaire** — generate a real release keystore now (smallest install base it will ever
   have), put `key.properties` on the build machine only, rebuild, publish the new fingerprint,
   and tell users about the one-time uninstall. Register the new certificate with Android
   developer verification at the same time.
3. **All three** — replace the debug fallback in Gradle with a hard failure so this cannot recur.
4. **All three** — register the package names in the Android Developer Console (the console for
   developers who distribute only outside Google Play). Since 2026-09-30 installs in
   Brazil/Indonesia/Singapore/Thailand already require registration from participating stores, and
   the requirement goes global in 2027; unregistered apps fall back to ADB/advanced flow. A Play
   account is not required, and Google forbids opening a new one after a termination.

Signing-key changes have a dedicated procedure: `docs/KEY-CHANGE.md` (announcement slot,
`--allow-key-change`, one-time uninstall, developer-verification registration).

Tracking lives in the app repos (issues created 2026-10-29):
[force-workout-helper#7](https://github.com/gnitoapp-com/force-workout-helper/issues/7) (untrack keystore +
credentials, rotate password, hard-fail signing, register) ·
[units2units#1](https://github.com/gnitoapp-com/units2units/issues/1) (locate/rotate keystore, untrack
plaintext credentials, hard-fail signing, register) ·
[romanitaire#2](https://github.com/gnitoapp-com/romanitaire/issues/2) (create release keystore, rebuild,
publish new fingerprint + one-time uninstall notice, register).

Now partly machine-enforced: `scripts/apk-checksums.sh` refuses to publish when an APK's signing
certificate differs from the committed `signerCertSha256`, and refuses when it cannot read the
certificate at all. A deliberate change needs `--allow-key-change`, plus the announcement and the
developer-verification registration that go with it.

## P3 — polish

- **D20.** Home page: product logos/one-liners beside the three buttons and the company relation
  in the footer. **Dropped by the owner on 2026-10-30** — the page stays as-is.
- **D21.** No monitoring and no performance budget. A monthly `lighthouse-ci` run against the live
  site would still be worthwhile; not done.
- **D22.** Placeholder cspell dictionary — **resolved** (`e0144db`).
- **D23.** `ui.feedback` posting to an unconfigured Google Analytics — **resolved** (`441455d`).
- **D26.** Code blocks on the support page were white-on-white, and the legal pages were rendered
  without Docsy's content wrapper. Two causes: the legacy `pygmentsUseClasses: false` forced inline
  Chroma styles (light background) while the dark theme supplied light text — Docsy's dark Chroma
  classes are opt-in and were not imported; and Docsy 0.18's generic `all.html` emits `.Content`
  bare, so those pages had no page title, no prose styles and no code-block styling. Fixed with
  `noClasses: false`, `@import 'td/code-dark'`, and project layouts that render plain pages through
  `_td-content`. **Resolved** (`147b47e`).

---

## Status and remaining work

The audit is closed on this side. Everything in `P0`–`P3` is either fixed, decided, or explicitly
dropped; the branch holds the whole result.

1. **Owner action: advance `main` when ready.** The branch (`major-enhancements`) is the complete,
   verified build; `main` is the 2026-07-27 baseline. Only a push to `main` deploys (the deploy job
   is gated to it). The first deploy after merging also exercises the two things that can only run
   there: the post-deploy smoke test and the redirect-free canonical check against production.
2. **App repos: signing keys.** Generate the three new keys, sign, publish with the pre-written
   notices and `--allow-key-change`, register the package names — `force-workout-helper#7`,
   `units2units#1`, `romanitaire#2`, procedure in `docs/KEY-CHANGE.md`.
3. **App repos: privacy links.** `romanitaire#3` (404 link) and `force-workout-helper#8` (stale
   second policy).
4. **Optional:** D21 monitoring, and Docsy's offline search if the site should ever have search
   (it currently has none, deliberately).

Operational note for whoever runs the dev server: `hugo server` writes development HTML into
`public/` by default, so running it alongside a production build leaves pages pointing at a
deleted stylesheet (the site then renders unstyled). `scripts/hugo` now injects
`--renderToMemory` for `serve`/`server`, and `public/` is written only by
`npm run build:production`.
