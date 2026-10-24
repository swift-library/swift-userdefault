# swift-userdefault Agent Guide

Read `README.md` and `CONTRIBUTING.md` before editing.

## Authority and route

- `Package.swift` owns products, targets and dependencies.
- `Sources/` owns implementation and colocated module DocC catalogs.
- `Tests/` owns behavior checks, including release-mode encoding failure coverage.
- `.github/swift-package.json` owns CI validation; `CONTRIBUTING.md` lists local
  build, debug and release test, release build and strict formatting commands.
- `README.md` owns installation and usage; `CHANGELOG.md` owns release history.
- `.github/release.json` owns release inputs.
- Keep machine-specific paths, generated build output and temporary state in
  ignored local output directories. Preserve source and dependency notices.

## Code Review Rules

### Compatibility and versioning

- Flag a change to public API or observable behavior, including a raised
  minimum platform or Swift version, without the change record the
  [organization versioning standard](https://github.com/swift-library/.github/blob/master/VERSIONING.md) requires. Safe
  path: record breaking changes under `## Unreleased` with a **Breaking**
  marker naming any new minimums. Assign the version at release time.

### Claims

- Flag README, DocC, or release-note statements that the code and tests do
  not support: capabilities that do not exist, existing behavior described as
  new, or platforms CI does not build. Safe path: describe what the code
  shows.

### Public documentation

- Flag a new public symbol without a documentation comment, and public prose
  that compares the package with other projects or describes internal
  process. Safe path: document the symbol, and describe only this package's
  own behavior.

### Tests

- Flag a behavior change without a test that would fail before the change.
  Safe path: add the test beside the existing suite for that behavior.
