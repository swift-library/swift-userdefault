# CHANGELOG

<!-- 
Add new items at the end of the relevant section under **Unreleased**.
-->

## [Unreleased]

### Added

- Doc comments for `UserDefault`, each of its initializers, and
  `UserDefaultWrapper` that describe storage formats and when reading returns
  the default value.
- A README with installation, quick start, and usage guides.

### Changed

- The minimum Swift tools version is 5.8, the version swift-gyb requires.
- Assigning `nil` to an optional `Codable` property removes its key instead of
  storing JSON `null`.

### Fixed

- Resolving the package failed with "product 'Gyb' required by package
  'swift-userdefault' target 'UserDefault' not found in package 'swift-gyb'".
  swift-userdefault now requires swift-gyb 0.0.2 and uses its `GybPlugin`
  build tool plugin, so dependents no longer need to pin swift-gyb 0.0.1.
- Assigning `nil` to an optional `RawRepresentable` property, such as an
  optional enumeration with `UserDefaultUtils`, crashed with "Attempt to set a
  non-property-list object <null>". It now removes the key.
- Reading a `Codable` property whose stored data cannot be decoded as the
  property's type called `fatalError`. It now returns the default value.
- A property whose type is both `RawRepresentable` and `Codable` failed to
  compile with an ambiguous initializer error. It now stores the `rawValue`;
  raw-value storage takes precedence over JSON.
- `Optional`'s `init?(rawValue:)` in `UserDefaultUtils` returned `nil` wrapped
  in `.some` for a raw value that matched no case, so an optional enumeration
  read `nil` instead of its default value. The initializer now fails for an
  unmatched raw value.

---

## [0.0.1] - 2023-05-02

- `UserDefault` initial release.

<!-- Link references for releases -->

[Unreleased]: https://github.com/swift-library/swift-userdefault/compare/0.0.1...HEAD
[0.0.2]: https://github.com/swift-library/swift-userdefault/compare/0.0.1...0.0.2
[0.0.1]: https://github.com/swift-library/swift-userdefault/releases/tag/0.0.1
