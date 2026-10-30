/**
 * Make sure Hugo gets a Dart Sass it can use.
 *
 * Two installed packages declare a binary named `sass`:
 *   - `sass-embedded` (the embedded-protocol CLI that Hugo drives), and
 *   - the pure-JS `sass` package, which npm pulls in through sass-embedded's
 *     `*-unknown` optional platform packages.
 * Whichever npm links last wins, and when the pure-JS one wins Hugo fails with
 *   TOCSS-DART: got unexpected EOF when executing "sass"
 * because that CLI cannot serve the embedded protocol (`sass --embedded`).
 *
 * This script repoints node_modules/.bin/sass at sass-embedded. It runs as the
 * root `postinstall` hook, so `npm ci` in CI ends up in the same state as a
 * local install. No-op when sass-embedded is absent or on Windows (npm's .cmd
 * shims need a different fix; the site is built on Linux and macOS).
 */
import fs from 'node:fs';
import path from 'node:path';

if (process.platform === 'win32') {
  process.exit(0);
}

const bin = path.join('node_modules', '.bin', 'sass');
const target = path.resolve('node_modules/sass-embedded/dist/bin/sass.js');

if (!fs.existsSync(target)) {
  console.warn('ensure-dart-sass: sass-embedded not installed, leaving the sass bin alone');
  process.exit(0);
}

const relative = path.relative(path.dirname(path.resolve(bin)), target);
try {
  fs.chmodSync(target, 0o755);
} catch {
  // Permission errors are reported by the build; nothing useful to add here.
}
try {
  const current = fs.readlinkSync(bin);
  if (current === relative) process.exit(0);
} catch {
  // Missing or not a symlink: fall through and replace it.
}
try {
  fs.unlinkSync(bin);
} catch {
  // Nothing to replace.
}
fs.symlinkSync(relative, bin);
console.log(`ensure-dart-sass: linked ${bin} -> ${relative}`);
