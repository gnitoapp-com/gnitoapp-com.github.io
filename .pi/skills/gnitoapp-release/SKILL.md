---
name: gnitoapp-release
description: Publish a new Android APK build for Units2Units, Force Workout Helper or Romanitaire on gnitoapp.com. Use when asked to publish/release a new app version, replace an APK, bump the version or buildNumber, add screenshots for a product page, or verify that a release is consistent across version.json, the landing page and the download link.
---

# Publish a GnitoApp app release

This repo is the download site for three apps. A release is a content change, one local commit
on `main`, and a push (only when the owner asks). Follow the order below; every step is a check
that has caught a real mistake in this repo before.

First read the repo `AGENTS.md` (invariants) and the "D9" / "D19" entries in
`docs/MAINTENANCE.md`, because APK size and integrity are the two recurring problems.

## Inputs you must have

- Product: `units2units` | `forceworkouthelper` | `romanitaire`
- New semver `version` (e.g. `1.2.1`) and integer `buildNumber`
- The new `.apk` file, path known
- Optional: new/changed screenshots, release notes text

If any is missing, stop and ask. Never invent a build number — `buildNumber` is monotonic
per product (`static/<product>/version.json`). Never guess a version from the APK filename.

## 1. Inspect the current state

```bash
git status --short && git log --oneline -5
cat static/<product>/version.json
grep -n "Download APK\|<product>_v\|>1\.[0-9]" content/en/<product>/index.md
ls -lh static/<product>/
```

The version lives in **four** places; all must end up equal:

1. `static/<product>/version.json` → `version` + `buildNumber`
2. download button label: `Download APK X.Y.Z (Android)`
3. download button `href`: `/…/<product>_vX_Y_Z.apk` (dots become underscores)
4. the "Quick Info" table version cell

## 2. Verify the APK before wiring it up

```bash
ls -lh "<new-apk>"
sha256sum "<new-apk>"
unzip -l "<new-apk>" | head -5           # must be a valid zip; catches truncated uploads
```

Rules: one current APK per product, plus at most the immediately previous one if the owner
asked to keep it. The site must stay well under the 1 GB GitHub Pages limit — delete the
superseded APK in this same commit unless told otherwise.

## 3. Place the file and update the version file

```bash
cp "<new-apk>" static/<product>/<product>_vX_Y_Z.apk
```

Edit `static/<product>/version.json`, preserving its 4-space indentation and key order, and
keeping `buildNumber` as a number:

```json
{
    "version": "X.Y.Z",
    "buildNumber": N
}
```

Keep the old `static/<product>/version.json` semantics: the apps poll this URL, so it must be
valid JSON on the first try (`python3 -m json.tool static/<product>/version.json`).

## 4. Update the landing page

In `content/en/<product>/index.md`, change exactly the button label, the button `href`, and the
Quick Info table version cell. Do not reformat the surrounding HTML, do not restyle, do not
"fix" the page architecture during a release (that is D11 and its own task).

If screenshots change: replace files in `static/<product>/screenshots/`, keep the numeric
naming, keep every `<img>` order/alt text in sync, and respect the budget (< 300 KB each,
longest edge ≤ 700 px). Optimize before committing:

```bash
oxipng -o4 --strip safe static/<product>/screenshots/*.png   # or: cwebp -q 82 in.png -o out.webp
```

## 5. Build and verify (do not skip)

```bash
export PATH="$HOME/.local/go-sdk/bin:$PATH"   # Go is needed to resolve the Docsy module
npm run build:production 2>&1 | grep -E "WARN|ERROR|Total in"   # no new warnings

# the linked APK exists in the built site and is the new one
grep -o 'href="[^"]*\.apk"' public/<product>/index.html
test -f "public$(grep -o '/<product>/[^"]*\.apk' public/<product>/index.html | head -1)" && echo APK-OK

# the four version locations agree
grep -n 'X\.Y\.Z' public/<product>/index.html
python3 -c "import json;d=json.load(open('public/<product>/version.json'));print(d)"

# no leftover references to the removed APK
grep -rn "v<old>_" content/ static/ | head
```

Also confirm the page renders (spot-check the built HTML: one `<h1>`, three download/store
links, screenshots present) and that `public/` did not grow by more than the new APK's size:

```bash
du -sh public static/<product>
```

## 6. Commit — local, never a PR

```bash
git add "static/<product>/<product>_vX_Y_Z.apk" \
        "static/<product>/version.json" \
        "content/en/<product>/index.md" \
        "static/<product>/screenshots"   # only if screenshots changed
git status --short
git commit -m "Publish <Product> X.Y.Z (build N) refs #<issue>"
```

- Never `git add -A`/`git add .` here: APKs are 70–100 MB and `public/` must never be staged.
- If a commit needs to reference the issue number, use `refs #N`/`implements #N`.
- Report back: commit hash, branch, "local and unpushed", APK size, and the build evidence
  (`Total in …`, the four matching version strings, the resolved APK path).

Push only if the owner explicitly asks: `git push origin main`.

## Failure modes seen here

- Bumping the page text but not `version.json` (or vice versa) → in-app updater sees the old
  version and offers the same build again.
- Uploading an APK with dots in the filename or under a new name while the button still points
  at the old file → 404 on the download button.
- Keeping every historical APK → the site approaches the Pages size limit and every deploy
  re-uploads hundreds of MB (D9).
- Building without Go on `PATH` → `failed to download modules: binary with name "go" not found`.
- Trusting `npm run build:preview`: it substitutes `DEPLOY_PRIME_URL` or `/` as baseURL. Use
  `build:production` or an explicit `--baseURL https://gnitoapp.com/` when checking URLs.
