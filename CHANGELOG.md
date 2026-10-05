# Changelog

## Unreleased

## 0.1.0

The first tagged release.

### Added

- Doc comments for `UserDefault`, each of its initializers, and
  `UserDefaultWrapper` that describe storage formats and when reading returns
  the default value.
- A README with installation, quick start, and usage guides.

### Changed

- The minimum Swift tools version is 5.8, the version swift-gyb requires.
- The minimum platforms are macOS 12, iOS 15, tvOS 15 and watchOS 9, the
  oldest targets Xcode 27 builds for.
- Assigning `nil` to an optional `Codable` property removes its key instead of
  storing JSON `null`.

### Fixed

- Resolving the package failed with "product 'Gyb' required by package
  'swift-userdefault' target 'UserDefault' not found in package 'swift-gyb'".
  swift-userdefault now depends on swift-gyb 0.1.x and uses its `GybPlugin`
  build tool plugin.
- Assigning `nil` to an optional `RawRepresentable` property, such as an
  optional enumeration with `UserDefaultUtils`, crashed with "Attempt to set a
  non-property-list object <null>". It now removes the key.
- Reading a `Codable` property whose stored data cannot be decoded as the
  property's type called `fatalError`. It now returns the default value.
- A property whose type is both `RawRepresentable` and `Codable` failed to
  compile with an ambiguous initializer error. It now stores the `rawValue`;
  raw-value storage takes precedence over JSON.
- Assigning a `Codable` value that `JSONEncoder` can't encode stopped the
  program with `fatalError`. The stored value now stays unchanged, and debug
  builds stop at an assertion.
- `UserDefaultUtils` no longer triggers the retroactive conformance warning for
  `Optional: RawRepresentable` on Swift 5.10 and later.
- `Optional`'s `init?(rawValue:)` in `UserDefaultUtils` returned `nil` wrapped
  in `.some` for a raw value that matched no case, so an optional enumeration
  read `nil` instead of its default value. The initializer now fails for an
  unmatched raw value.
