# Contributing

External contributions are welcome. Use a Conventional Commit PR title and run
the local validation commands below before submitting changes. Describe the
behavior being changed and include a regression test for a bug fix. Follow the
[shared contribution guide](https://github.com/swift-library/.github/blob/master/CONTRIBUTING.md)
and [release standard](https://github.com/swift-library/.github/blob/master/VERSIONING.md).
Maintainers follow the shared [signing instructions](https://github.com/swift-library/.github/blob/master/MAINTENANCE.md#signing).

```sh
swift build
swift test
swift test -c release
swift build -c release
xcrun swift-format lint --strict --configuration .swift-format --recursive Package.swift Sources Tests
```

Release-mode tests check that encoding failures preserve the stored value;
debug builds stop at an assertion.
The shared workflows read [.github/swift-package.json](.github/swift-package.json)
for the compiler matrix, iOS build and DocC targets. Required checks are
`policy / policy` and `validate / result`.

By submitting a contribution, you confirm your right to license it under
[Apache-2.0 WITH Swift-exception](LICENSE.txt). Preserve third-party notices.
