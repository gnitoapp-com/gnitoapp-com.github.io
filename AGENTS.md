# gnitoapp.com — operating manual

Marketing + app-download site for **GnitoApp.com** (an operating division of 3827992 Canada
Inc). Three product landing pages — Units2Units, Force Workout Helper, Romanitaire — plus
privacy, terms, support and search pages. Signed APKs for Android are served from this repo.

Stack: Hugo (extended) + [Docsy](https://www.docsy.dev) as a Hugo module, deployed by
GitHub Actions to GitHub Pages on the custom domain **https://gnitoapp.com**.

**Read `docs/MAINTENANCE.md` before any structural, dependency or release work.** It holds
the audit, the known defects with evidence, and the prioritised backlog. This file is the
short operating manual; that file is the long memory.

## Layout

| Path | Purpose |
| --- | --- |
| `content/en/_index.md` | Home page (Docsy blocks: cover + feature) |
| `content/en/{units2units,forceworkouthelper,romanitaire}/index.md` | Product landing pages — raw HTML embedded in Markdown |
| `content/en/privacy/` | Privacy policy: `_index.md` (EN) + `privacy_zh.md` (ZH as a separate page, not i18n) |
| `content/en/terms/index.md`, `support.md`, `search.md` | Legal, contact, search page |
| `static/<product>/` | `version.json`, the current `*.apk`, `SHA256SUMS`, `screenshots/`, `images/logo_200_square.png`. Copied verbatim — never processed by Hugo |
| `data/apk_checksums.json` | **Generated** per-APK SHA-256, size, signing-certificate fingerprint, package/versionCode. Never hand-edit; run `scripts/apk-checksums.sh` |
| `scripts/apk-checksums.sh` | Regenerates the integrity data (`--check` verifies it; CI runs `--check`) |
| `layouts/shortcodes/apk-checksum.html` | Renders the "Verify this download" block on each product page from that data |
| `hugo.yaml` | The site config that is actually used (language `en`, `contentDir: content/en`, Docsy module import, baseURL) |
| `layouts/_default/baseof.html` | Local override of Docsy's `baseof.html`; also forces dark mode (see D4 in the maintenance doc) |
| `layouts/404.html` | Not-found page override |
| `assets/scss/_variables_project.scss` | The only supported place for Docsy/theme SCSS overrides (currently empty) |
| `.github/workflows/hugo.yaml` | Build + deploy to GitHub Pages, triggered by push to `main` |

Template leftovers — do **not** treat as documentation and do **not** extend them:
`README.md`, `CONTRIBUTING.md` (Google Docsy template text), `hugo-disabled.toml`,
`config.yaml`, `docsy.work`, `docsy.work.sum`, `netlify.toml`, `Dockerfile`,
`docker-compose.yaml`. See D5–D7.

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

```bash
# dev server (hot reload, drafts + future-dated content)
npx hugo server --port 1313 --bind 127.0.0.1

# production build — exactly what CI runs (writes ./public, ~267 MB, gitignored)
npm run build:production                  # = hugo --cleanDestinationDir --minify, plus the stub link check

# full CI simulation from a clean tree (postinstall links the embedded Dart Sass)
export PATH="$HOME/.local/go-sdk/bin:$PATH"
rm -rf node_modules public && npm ci && npm run build:production

# after changing the Docsy module version: refresh the generated npm workspace and commit it
hugo mod npm pack && npm install && git add packages/hugoautogen/package.json

# explicit-URL build (use this to compare against the live site)
npx hugo --gc --minify --baseURL "https://gnitoapp.com/"

# build evidence
grep -o 'og:url" content="[^"]*"' public/units2units/index.html   # must be https://
grep -c 'rel=canonical' public/units2units/index.html             # exactly 1
grep -c '<loc>https://gnitoapp.com' public/sitemap.xml
npx hugo config | head -5                                        # confirms hugo.yaml is the active config
```

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

1. **Version consistency.** A product's version lives in four places: `static/<product>/version.json`
   (`version`, `buildNumber`), the download button label, the download button href, and the
   version cell of the "Quick Info" table — plus the APK filename
   (`<product>_v1_2_0.apk` ⇄ `1.2.0`). `scripts/apk-checksums.sh --check` (and therefore CI)
   enforces version.json ↔ filename ↔ page link ↔ button label ↔ APK `versionName`/`versionCode`;
   the *table cell* is not machine-checked, so update it by hand.
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
6. **Images stay small.** New screenshots: ≤ 300 KB each, longest edge ≤ 700 px (they render
   at 230 CSS px). Optimize before committing.
7. **URLs are stable.** Page paths are `/<product>/` and are linked from the App Store
   listings and existing QR/APK pages. Do not rename or move a product page; add a redirect
   or alias if one must change.
8. **The site is always dark.** `layouts/partials/hooks/head-end.html` sets
   `data-bs-theme="dark"` in `<head>`, before first paint; there is no local `baseof.html` any
   more (D4). Any new page/component must be legible on a dark background; do not add white
   panels with hard-coded text colors (which the current product pages do — D11).
9. **Signing identity is a contract.** Never sign a release with a debug key, never commit a
   keystore or `key.properties` to any repo, and never publish an APK whose certificate differs
   from the published `signerCertSha256`. `scripts/apk-checksums.sh` enforces the last one and
   requires `--allow-key-change` for a deliberate rotation (which also needs a page note and
   Android developer-verification registration). See D25.
10. **`hugo.yaml` is the config.** `config.yaml` is a Docsy version guard and `hugo-disabled.toml`
   is dead template scaffolding. Put every setting in `hugo.yaml`.

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

## Definition of done (any change that ships)

```bash
npm run build:production                     # no new WARN/ERROR lines
./scripts/apk-checksums.sh --check           # APK ↔ checksum ↔ version ↔ page link
grep -o 'og:url" content="[^"]*"' public/units2units/index.html   # https, not http
grep -c 'rel=canonical' public/units2units/index.html             # exactly 1
grep -o 'href="[^"]*\.apk"' public/<product>/index.html           # path matches version
test -f "public$(grep -o '/<product>/[^"]*\.apk' public/<product>/index.html | head -1)"
git status --short                           # only intended files; no public/, no node_modules/
```

Also: the four version locations agree, screenshots/APK budgets respected, and
`docs/MAINTENANCE.md` updated if you close or open a defect.
