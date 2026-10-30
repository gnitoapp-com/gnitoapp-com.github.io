# gnitoapp.com — operating manual

Marketing + app-download site for **GnitoApp.com** (an operating division of 3827992 Canada
Inc). Three product landing pages — Units2Units, Force Workout Helper, Romanitaire — plus
privacy, terms, support and search pages. Signed APKs for Android are served from this repo.

Stack: Hugo (extended) + [Docsy](https://www.docsy.dev) as a Hugo module, deployed by
GitHub Actions to GitHub Pages on the custom domain **https://gnitoapp.com**.

**Read `docs/MAINTENANCE.md` before any structural, dependency or release work.** It holds
the audit, the known defects with evidence, and the prioritised backlog. This file is the
short operating manual; that file is the long memory.

## Hard rule: `main` is off-limits

**Never modify, commit to, merge into, fast-forward, rebase, reset, force-push or update the ref of
`main` — locally or on `origin` — without an explicit instruction from the owner, in the current
message, that names `main`.**

"Push", "ship it", "deploy", "get it live" are **not** that instruction. They mean: push the working
branch. The deploy workflow runs from `main`, so a task can appear to require moving it — when that
happens, **stop and ask**. Do not infer.

This rule is here because an agent once fast-forwarded `main` to a feature branch on the strength of
the single word "push" and deployed it. Work stays on a working branch until the owner advances
`main` themselves.

## Layout

| Path | Purpose |
| --- | --- |
| `content/en/_index.md` | Home page (Docsy blocks: cover + feature) |
| `content/en/{units2units,forceworkouthelper,romanitaire}/index.md` | Product pages: front matter (`layout: product`, `product: <key>`) plus the product description only |
| `data/products/<product>.yaml` | Per-product facts: `platforms` (required), tagline, category, licence, store link, badges, screenshots, logo, optional `notice` (Markdown, rendered above the download buttons) and optional `version` (only for non-Android products — Android takes it from the APK) |
| `layouts/_default/product.html` + `layouts/partials/product/*` | Renders the shared product chrome from that data |
| `content/en/privacy/` | Privacy policy: `_index.md` (EN) + `privacy_zh.md` (ZH as a separate page, not i18n) |
| `content/en/terms/index.md`, `support.md` | Legal and contact pages |
| `static/<product>/` | `version.json`, the current `*.apk`, `SHA256SUMS` and `images/logo_200_square.png`. Copied verbatim |
| `assets/screenshots/<product>/` | Screenshot sources (PNG). Hugo renders 230 px and 460 px WebP variants — add a file here and list it in `data/products/<product>.yaml`; never put screenshots back in `static/` |
| `data/apk_checksums.json` | **Generated** per-APK SHA-256, size, signing-certificate fingerprint, package/versionCode. Never hand-edit; run `scripts/apk-checksums.sh` |
| `scripts/apk-checksums.sh` | Regenerates the integrity data (`--check` verifies it; CI runs `--check`) |
| `scripts/hugo` | Runs the npm-pinned Hugo with node_modules/.bin and Go on PATH — **there is no system-wide `hugo`** |
| `scripts/generate-brand-assets.sh` | Generates the favicon set, `site.webmanifest`, the navbar mark and the 1200×630 social cards from `assets/images/logo/gnitoapp-com-logo.png`. Re-run after changing the master logo; never hand-edit the outputs |
| `assets/images/logo/gnitoapp-com-logo.png` | Master brand logo (550×550). Source for every generated icon |
| `static/favicon*`, `static/apple-touch-icon.png`, `static/android-chrome-*.png` | Generated icons. Docsy discovers them by these conventional names in `static/` |
| `layouts/partials/apk-verify.html` | Renders the "Verify this APK" block on each product page from that data |
| `layouts/partials/navbar.html` | Theme 0.18.0 navbar + one change: menu entries with children render as a Bootstrap dropdown ("Apps"). **Re-diff against the theme on every Docsy upgrade** |
| `hugo.yaml` | The site config that is actually used (language `en`, `contentDir: content/en`, Docsy module import, baseURL) |
| `layouts/_default/baseof.html` | Local override of Docsy's `baseof.html`; also forces dark mode (see D4 in the maintenance doc) |
| `layouts/404.html` | Not-found page override |
| `assets/scss/_variables_project.scss` | Theme **variables** only (Docsy imports it before Bootstrap, so rules here lose to theme rules) |
| `assets/scss/_styles_project.scss` | Project **CSS rules** — imported last, so they win equal-specificity fights. All page/component styles live here |
| `.github/workflows/hugo.yaml` | Build + deploy to GitHub Pages, triggered by push to `main` |

The template leftovers that used to be listed here (Docsy's example README and
CONTRIBUTING, `hugo-disabled.toml`, `config.yaml`, the `docsy.work` workspace,
`netlify.toml`, the broken Docker files) were deleted in `441455d`. `README.md` and
`LICENSE` now describe this project.

Favicons are convention-based: Docsy 0.18 links `favicon.ico`, `favicon-NxN.png` and
`apple-touch-icon*.png` from `static/` automatically, so no template change is needed to add a
size — drop the file in and it is linked.

**Licence:** proprietary, all rights reserved (standing owner decision). Third-party
dependencies keep their own licences — see `LICENSE`. Do not add Apache/MIT headers to
this repo's files, and do not relicense the content or the APKs.

## Toolchain (verified on this machine, 2026-10-29)

| Component | Version in repo | Notes |
| --- | --- | --- |
| Hugo | `hugo-extended` 0.169.0 (`package.json` devDependency, exact) | **One version everywhere**: `npm run build:*` locally and in CI. Bump with `npm run update:hugo` — never edit the workflow |
| Docsy | v0.18.0 (`go.mod`, module path `github.com/docsy/docsy/theme`) | Moved to the `docsy` org at v0.18; the old `github.com/google/docsy` path is gone. `hugo mod npm pack` supplies Bootstrap 5.3.8 + Font Awesome 7.3.1 |
| Node | 22 (`.nvmrc`), 22.23.2 installed locally | CI reads `.nvmrc` via `setup-node` |
| npm | 10.9.8 | `package-lock.json` is tracked; always install with `npm ci` |
| Go | not installed system-wide; used only to download the Docsy module | see bootstrap below |
| Dart Sass | `sass-embedded` 1.105.0 (devDependency, exact) | Docsy 0.17+ requires it. `scripts/ensure-dart-sass.mjs` runs as `postinstall` to link `node_modules/.bin/sass` at it — see D15 |

### Bootstrap (one-time, local)

```bash
npm ci                                               # exact tree from the committed lockfile, incl. the hugo 0.161.1 binary
export PATH="$HOME/.local/go-sdk/bin:$PATH"          # Go 1.24.5 SDK already unpacked here; add to your shell profile
```

`hugo` will not resolve the Docsy module without a `go` binary on `PATH`. CI relies on the Go
that ships with the `ubuntu-latest` image and logs `go version` in a preflight step.

## Commands

Hugo is pinned by `package.json` as the `hugo-extended` devDependency. For convenience a
**system-wide copy of the same version is installed** (`/usr/local/bin/hugo` 0.169.0+extended,
with `/usr/local/bin/sass` = Dart Sass 1.105.0 and Go 1.26 from `dnf`), so a bare `hugo` also
works. Prefer `./scripts/hugo` or `npm run build:production` anyway: they always use the npm pin
and put `node_modules/.bin` on `PATH`. The system copy does not follow `package.json` — after a
Hugo bump, either reinstall it or use the wrapper.

```bash
./scripts/hugo version                   # 0.169.0+extended, the same binary CI uses
./scripts/hugo server --port 1313 --bind 127.0.0.1   # dev server (wrapper forces --renderToMemory)

# production build — exactly what CI runs (writes ./public, ~267 MB, gitignored)
npm run build:production                  # = hugo --cleanDestinationDir --minify, plus the stub link check

# full CI simulation from a clean tree (postinstall links the embedded Dart Sass)
rm -rf node_modules public && npm ci && npm run build:production

# after changing the Docsy module version: refresh the generated npm workspace and commit it
./scripts/hugo mod npm pack && npm install && git add packages/hugoautogen/package.json

# explicit-URL build (use this to compare against the live site)
./scripts/hugo --gc --minify --baseURL "https://gnitoapp.com/"

# build evidence
grep -o 'og:url" content="[^"]*"' public/units2units/index.html   # must be https://
grep -c 'rel=canonical' public/units2units/index.html             # exactly 1
grep -c '<loc>https://gnitoapp.com' public/sitemap.xml
./scripts/hugo config | head -5                                   # confirms hugo.yaml is the active config
```

**Never let a dev server write `public/`.** `hugo server` writes development HTML
(unminified, `noindex`, un-fingerprinted CSS) to `public/` by default; a production build writing the
same directory then deletes that CSS and pages render unstyled. `scripts/hugo` therefore injects
`--renderToMemory` for `serve`/`server` (as `npm run serve` already did), and `public/` is only ever
written by `npm run build:production`, which cleans it first.

Cold build with an empty Hugo module cache takes ~15 s (Docsy download); warm builds take ~1.5 s.
CI caches both npm and `$RUNNER_TEMP/hugo_cache`.

## Deploy

Push to `main` → `Deploy Hugo site to Pages` → build job → `actions/deploy-pages`.
Production is served by GitHub Pages; there is no staging environment and no Netlify
deployment (`netlify.toml` is leftover — D7). Rollback = revert the commit and push.

The deploy job is gated to `github.ref == 'refs/heads/main'`, so a `workflow_dispatch`
started from a branch runs the build (useful to validate a workflow change) but cannot
publish. Pushing to any other branch triggers nothing at all.

Release procedure for a new APK lives in the project skill
`.pi/skills/gnitoapp-release/SKILL.md` — load it (`/skill:gnitoapp-release`) instead of
re-deriving the four version locations by hand.

## Invariants — break these and the site is wrong

1. **Version consistency.** `static/<product>/version.json` is the only place a version is typed.
   The button label, href, Quick Info cell and checksum block all come from
   `data/apk_checksums.json`, which `scripts/apk-checksums.sh` generates from the APK. `--check`
   enforces version.json ↔ APK filename ↔ generated data ↔ APK `versionName`/`versionCode`, and
   `--rendered public` enforces the built page. Run both (CI runs both).
2. **Integrity data is part of a release.** Any change to an APK means re-running
   `scripts/apk-checksums.sh` in the same commit. The landing page publishes that hash and the
   signing-certificate fingerprint, and the CI step fails if they disagree with the file.
3. **APK live at the linked path.** Every `href` to an `.apk` must resolve to a file that
   exists in `static/` and therefore in `public/`.
4. **Legal pages are the owner's words.** Do not rewrite `content/en/privacy/**` or
   `content/en/terms/**` prose, even when it contradicts product marketing (it does — D12).
   Report the inconsistency; change text only when explicitly asked.
5. **No new large binaries.** One APK per product, plus at most the immediately previous one
   if the owner asks. Delete superseded APKs in the same commit (D9). Never commit
   `public/`, `resources/` or `node_modules/`.
6. **Screenshots go through Hugo.** Sources live in `assets/screenshots/<product>/` (keep new ones
   ≤ ~1400 px wide so the repo does not grow) and are rendered to 230/460 px WebP with `srcset` and
   explicit dimensions. Total published weight is ~600 KB for all 17 — keep it under 2 MB.
7. **URLs are stable.** Page paths are `/<product>/` and are linked from the App Store
   listings and existing QR/APK pages. Do not rename or move a product page; add a redirect
   or alias if one must change.
8. **The site is always dark.** `layouts/partials/hooks/head-end.html` sets
   `data-bs-theme="dark"` in `<head>`, before first paint; there is no local `baseof.html` any
   more (D4). Any new page/component must be legible on a dark background. The product pages are
   a deliberate exception: they render a white surface via the `.product-page` class in
   `_variables_project.scss`, never via inline styles.
9. **Android-only blocks are gated by `platforms`.** The APK download button, the integrity
   block and the install guide render only when `platforms` contains `android`, and only then is
   `data/apk_checksums.json` required. A desktop-only product needs no APK, no checksum entry and
   no `static/<product>/` APK — set `platforms` and, if it has no APK, a `version:` in its data.
   The Quick Info "Platform Support" cell is derived from `platforms` (android, ios, windows,
   macos, linux, web), so a page cannot claim a platform it does not ship on.
   **Deliberately deferred:** per-platform installer downloads (a `downloads:` field rendered as
   buttons) — build it when the first desktop-only app is actually ready, not before. Until then a
   non-Android product renders with its store link only.
10. **Signing identity is a contract.** Never sign a release with a debug key, never commit a
   keystore or `key.properties` to any repo, and never publish an APK whose certificate differs
   from the published `signerCertSha256`. `scripts/apk-checksums.sh` enforces the last one and
   requires `--allow-key-change` for a deliberate rotation (which also needs a page note and
   Android developer-verification registration). The full procedure is `docs/KEY-CHANGE.md`;
   announcements go in the `notice` field of `data/products/<product>.yaml`. See D25.
11. **`hugo.yaml` is the only config.** `config.yaml` and `hugo-disabled.toml` are gone; do not
   reintroduce them. Put every setting in `hugo.yaml`.

### GitHub credentials on this machine

Two different tokens are in play, and mixing them up wastes an hour:

- **`git`** goes through the token router (`~/.local/bin/git-credential-tokenrouter`), which maps
  `github.com/<owner>/<repo>` to `~/.config/git/tokens/<owner>/_default`. For this repo that is
  the `gnitoapp-com` token, which has **Contents: write** — `git push` works with it.
  Verify with: `printf 'protocol=https\nhost=github.com\npath=gnitoapp-com/gnitoapp-com.github.io.git\n\n' | git credential fill`.
- **`gh`** uses its own keyring token (a different PAT), which has **no write access to this repo**:
  every `gh pr`/`gh issue` write fails with `403 Resource not accessible by personal access token`
  even when the token you are editing in the browser has the permissions. Do not re-edit PATs on
  that evidence — check which token `gh` actually holds first.
- **The router token cannot push commits that touch `.github/workflows/`** — GitHub rejects them
  with "refusing to allow a Personal Access Token to create or update workflow … without
  `workflow` scope". If the branch carries workflow edits, either push with a token that has
  **Workflows: Read and write** (explicitly, without changing the stored helper) or ask the owner
  to push. Never route such a push through `main`.
- For GitHub API writes here, override per command instead of touching global auth:
  `GH_TOKEN=$(cat ~/.config/git/tokens/gnitoapp-com/_default) gh pr close 12 --comment "..."`.
  That works once the router token carries **Pull requests: Read and write**,
  **Issues: Read and write** and **Workflows: Read and write** (needed to push workflow edits).

## Working agreement

- **No pull requests.** Work lands as **local commits on `main`**, one coherent commit per
  task, with the issue number in the message (`refs #123` / `implements #123`).
- **Push only when explicitly asked.** After every commit, state that it is local and
  unpushed, with hash + branch.
- CI is push-triggered; there is no PR gate. Do not propose a PR, a PR description, or a
  review thread as a delivery mechanism.
- **Open site work is tracked as issues in this repository** (#76–#83 when this was written).
  Findings, decisions and verification evidence belong in the issue thread; close an issue only
  with the evidence that satisfies its acceptance criteria.
- **Dependabot is a notification channel, not a review queue.** It opens at most one PR per
  ecosystem (npm, github-actions, gomod), weekly. Apply the bump locally on `main`, verify the
  build, then close the PR with a note — never merge it through the UI (D18).
  Note: the authenticated `gh` token has repo admin but **no Issues/PR write scope**, so it
  cannot comment on or close PRs. Either the owner closes them or the token needs that scope.
- Verified claims only: if you touch output, build it and quote the artifact. **The build must
  stay warning-free** — any `WARN` line is a defect to fix, not noise to live with.

## Quality gates

All gates are local and deterministic; CI runs the same commands, so a green local run means a
green build (except the post-deploy smoke test, which only runs on `main`).

```bash
npm run verify                  # check:apk + spell + lint:html + check:links
npm run build:production        # also runs the link check via postbuild:production
npm run smoke <url>             # post-deploy assertions (default: https://gnitoapp.com)
```

| Gate | What it enforces |
| --- | --- |
| `scripts/apk-checksums.sh --check` | APK ↔ SHA256SUMS ↔ version.json ↔ product data; refuses a changed signing certificate |
| `scripts/apk-checksums.sh --rendered public` | the built pages link the APK, show its version and publish its hash |
| `scripts/check-links.sh` | internal links and `#anchors` resolve in `public/` (188 links, 13 pages). `--external` probes external URLs as warnings |
| `html-validate` (`.htmlvalidate.json`) | HTML validity and a11y rules on the nine public pages; theme-only style rules are switched off with reasons in the config |
| `cspell` (`.cspell.yml`) | spelling in `content/` and `data/`, with the product/domain dictionary |
| `npm audit --omit=dev` | production dependency advisories (dev-only advisories are D24) |
| `scripts/smoke-test.sh` | after deploy: canonical, download link, version, SHA-256, SHA256SUMS content, APK 200, robots sitemap, sitemap scheme |

Not covered, deliberately: `pa11y`/axe automated a11y (needs a browser in CI; `html-validate`'s
a11y rules cover structure only), external links as hard failures (App Store/Bluesky bot-wall
automated requests), and `_print`/taxonomy output (theme-generated; taxonomies are dead weight per
#80).

## Definition of done (any change that ships)

```bash
npm run build:production                     # no new WARN/ERROR lines (runs the link check)
npm run verify                                # APK data, spelling, HTML, links
grep -o 'og:url" content="[^"]*"' public/units2units/index.html   # https, not http
grep -c 'rel=canonical' public/units2units/index.html             # exactly 1
grep -o 'href="[^"]*\.apk"' public/<product>/index.html           # path matches version
test -f "public$(grep -o '/<product>/[^"]*\.apk' public/<product>/index.html | head -1)"
git status --short                           # only intended files; no public/, no node_modules/
```

Also: the four version locations agree, screenshots/APK budgets respected, and
`docs/MAINTENANCE.md` updated if you close or open a defect.
