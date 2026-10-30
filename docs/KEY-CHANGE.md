# Changing an app's signing key

Read this before any release that changes the certificate an app is signed with —
including moving Romanitaire off the Android debug key and replacing Units2Units'
anonymous key. The site publishes the certificate fingerprint as the contract with
users, so a key change is a user-facing event, not a build detail.

## Why it needs a procedure

Android refuses to install an APK whose signing certificate differs from the
installed one (`INSTALL_FAILED_UPDATE_INCOMPATIBLE`). Users of the old build cannot
update in place: they must uninstall first, which deletes the app's local data. At
the same time the fingerprint on the product page changes, so anyone who verified
the previous download sees a different value and must be told why.

`scripts/apk-checksums.sh` therefore **refuses** to publish a changed certificate
unless it is run with `--allow-key-change`, and refuses to publish an APK whose
certificate it cannot read. Both refusals are the safety net behind this document.

## 1. Decide the identity, in writing

- Keep the existing key if it can be found and it is a real release key (a stable
  identity beats a pretty one: changing it breaks in-place updates).
- Replace it if it is a debug key, was lost, or has leaked.
- One key per product, stored outside any repository, backed up off-machine and in
  a password manager, with a strong password that is not shared with another app.

Record the decision in the app's repository issue (e.g. `romanitaire#2`,
`units2units#1`) before touching the site.

### Creating the key

`keytool` ships with the JDK (`dnf install java-17-openjdk-headless` on Fedora, or
any JDK). Generate the key **outside** the repository, with an interactive password
prompt — do not pass `-storepass`/`-keypass` on the command line, they end up in
your shell history:

```bash
mkdir -p ~/keys && chmod 700 ~/keys

keytool -genkeypair -v \
  -keystore ~/keys/<product>-release.jks \
  -storetype PKCS12 \
  -alias <product> \
  -keyalg RSA -keysize 4096 -validity 10000 \
  -dname "CN=GnitoApp.com, OU=gnitoapp.com, O=3827992 Canada Inc., L=Moncton, ST=NB, C=CA"
```

- `-validity 10000` days (~27 years): the key must outlive every future release.
  A certificate that expires stops signing and updating.
- Use a **unique, strong password per app**, stored in the password manager next to
  the keystore backup. Losing either freezes the app forever.
- The alias is cosmetic but is baked into the keystore; `<product>` keeps it obvious.

Confirm what you generated — the fingerprint printed here is what users will see on
the product page:

```bash
keytool -list -v -keystore ~/keys/<product>-release.jks | grep -E "Alias name|Owner|SHA256|Valid from"
```

Keep a PKCS12 copy of the keystore in the offline backup. When the app's Gradle build
uses it, point `android/key.properties` at the absolute path (`storeFile=`) and keep
that file untracked, exactly as described under "Keys and custody" in the release
skill.

## 2. Sign and verify the build

```bash
apksigner verify --print-certs <new.apk>        # DN + SHA-256 of the certificate
aapt2 dump badging <new.apk> | head -1          # versionName must match version.json
```

The DN must be the one you generated in step 1 (`CN=GnitoApp.com, O=3827992 Canada
Inc.…`), not `Android Debug` or `Unknown`; the SHA-256 must match
`keytool -list -v`'s output, because that value is what the site will publish.

## 3. Add the notice on the product page (before publishing)

`data/products/<product>.yaml` has a `notice` field, rendered above the download
button:

```yaml
notice: |
  **New signing key.** This build is signed with a new certificate
  (`<first 16 hex chars>…`). Because of that, Android cannot update an existing
  install in place: uninstall the old app once, then install this build. Any data
  stored in the old app is removed with it.
```

Keep the notice up for at least one release cycle, then delete the field.

Also update `content/en/support.md` if the change affects more than one product.

## 4. Publish the checksums with the new identity

```bash
cp <new.apk> static/<product>/<product>_v<X>_<Y>_<Z>.apk
# update static/<product>/version.json (version, buildNumber)

./scripts/apk-checksums.sh --allow-key-change   # explicitly accept the new cert
npm run build:production
./scripts/apk-checksums.sh --rendered public    # page shows the new version/hash
```

Committing `data/apk_checksums.json` + `SHA256SUMS` together with the APK is part
of the release, not an afterthought.

## 5. Tell users, concretely

- The notice above is the primary channel; it must state the uninstall step and the
  data-loss consequence.
- Keep the previous APK reachable until the notice has been live for a release
  cycle (the site normally keeps only the current APK, so this is an explicit
  exception).
- Support replies should quote the new fingerprint prefix so users can compare.

## 6. Register the new certificate with Android developer verification

Registration is per app package and tied to the signing identity; a new key means
the app must be registered again in the **Android Developer Console** (the console
for distribution outside Play — no Play account required). Do this in the same
window as the release, not weeks later: from 2026-09-30 unregistered apps rely on
ADB/advanced-flow installation in the four launch countries, and the requirement
goes global in 2027.

## 7. Verify what shipped

```bash
curl -s https://gnitoapp.com/<product>/SHA256SUMS
curl -s https://gnitoapp.com/<product>/ | grep -o '<code class=apk-verify__hash>[0-9a-f]*'
curl -s https://gnitoapp.com/<product>/ | grep -o 'class=product-notice'
```

Then install the published APK on a device with the old build present: it must
fail with a signature mismatch, which confirms users will need the uninstall step.
That failure is expected; the notice is what makes it acceptable.

## 8. If it goes wrong

- Wrong build published: revert the commit and push; Pages redeploys the previous
  state.
- Notice missing: fix the notice first, then re-publish; users must not be asked to
  uninstall without being told why.
- Key lost after publishing: the app can no longer be updated in place, ever — this
  is why the keystore backup comes before step 2, not after step 7.

## Checklist

- [ ] key located or created; backed up off-machine; password in the vault
- [ ] `apksigner` DN is a publisher identity, not debug/unknown
- [ ] `versionName` matches `version.json`, `versionCode` matches `buildNumber`
- [ ] notice added to `data/products/<product>.yaml`, mentioning uninstall + data loss
- [ ] `./scripts/apk-checksums.sh --allow-key-change` run and committed
- [ ] `./scripts/apk-checksums.sh --rendered public` passes
- [ ] developer-verification registration done for the new certificate
- [ ] support page and replies carry the new fingerprint prefix
- [ ] installed on a device: mismatch confirmed, notice explains it
