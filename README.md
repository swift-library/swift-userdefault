<div align="center">

<p align="center">
  <a href="https://github.com/swift-library/swift-userdefault"><img src="Documentation/Assets/Logo.svg" width="160" alt="swift-userdefault logo"></a>
</p>

<h1 align="center">swift-userdefault</h1>

<p align="center">
  Persist primitives, raw-value enums, and Codable models through one UserDefaults property wrapper.
</p>

<p align="center">
  <a href="https://github.com/swift-library/swift-userdefault/actions/workflows/ci.yml"><img src="https://github.com/swift-library/swift-userdefault/actions/workflows/ci.yml/badge.svg?branch=master" alt="CI"></a>
  <img src="https://img.shields.io/badge/Swift-6.0%2B-F05138?style=flat" alt="Swift 6.0+">
  <img src="https://img.shields.io/badge/platforms-macOS%2012%2B%20%7C%20iOS%2015%2B%20%7C%20tvOS%2015%2B%20%7C%20watchOS%209%2B-lightgrey?style=flat" alt="Platforms: macOS 12+ | iOS 15+ | tvOS 15+ | watchOS 9+">
  <a href="LICENSE.txt"><img src="https://img.shields.io/badge/license-Apache--2.0-blue?style=flat" alt="License: Apache-2.0 WITH Swift-exception"></a>
</p>

<p align="center">
  <a href="#overview">Overview</a> ·
  <a href="#quick-look">Quick look</a> ·
  <a href="#install">Install</a> ·
  <a href="#usage">Usage</a> ·
  <a href="#requirements">Requirements</a> ·
  <a href="#documentation">Documentation</a> ·
  <a href="#contributing">Contributing</a> ·
  <a href="#license">License</a>
</p>

</div>

## Overview

Declare a setting once and read or assign it as an ordinary property. Every access goes through the selected `UserDefaults` store, with type-directed storage and the declared default when a stored value cannot be read; see the [usage guide](Documentation/Reference/Usage.md) for formats and optional behavior.

## Quick look

```swift
import UserDefault

final class Settings {
  @UserDefault(key: "launchCount") var launchCount = 0
  @UserDefault(key: "nickname") var nickname: String? = nil
}

let settings = Settings()
settings.launchCount += 1
settings.nickname = "Ada"
settings.nickname = nil  // Removes the stored key.
```

## Install

Add the package and the `UserDefault` product to `Package.swift`:

```swift
dependencies: [
  .package(
    url: "https://github.com/swift-library/swift-userdefault.git",
    .upToNextMinor(from: "0.2.0")
  ),
],
targets: [
  .target(
    name: "YourTarget",
    dependencies: [
      .product(name: "UserDefault", package: "swift-userdefault"),
    ]
  ),
]
```

swift-userdefault generates part of its source at build time with the
`GybPlugin` build tool plugin from
[swift-gyb](https://github.com/swift-library/swift-gyb), which SwiftPM resolves
as a dependency of swift-userdefault. Xcode asks you to trust the plugin the
first time it builds the package. To build with `xcodebuild` without that
prompt, pass `-skipPackagePluginValidation`.

> [!NOTE]
> swift-userdefault is pre-1.0. Minor releases may include breaking changes, so
> depend on it with `.upToNextMinor(from:)`.

## Usage

Choose a key, a default value, and an optional `UserDefaults` store. The [usage guide](Documentation/Reference/Usage.md) covers primitives, raw-value enums, Codable models, optional values, and product selection.

## Requirements

- Swift 6.0 or later
- macOS 12 or later, iOS 15 or later, tvOS 15 or later, or watchOS 9 or later
- Python 3, available as `python3`, which the swift-gyb build tool plugin runs
  to generate source

## Documentation

- [Usage guide](Documentation/Reference/Usage.md): examples, behavior, and limits.
- [Module documentation](Sources/UserDefault/UserDefault.docc/UserDefault.md):
  the public API reference and module overview.

- API reference: doc comments on `UserDefault`, its initializers, and
  `UserDefaultWrapper` describe each storage format and when reading returns
  the default value. In Xcode, choose Product > Build Documentation to browse
  them.
- [Changelog](CHANGELOG.md)

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request. This
project follows the [code of conduct](https://github.com/swift-library/.github/blob/master/CODE_OF_CONDUCT.md).
Run the local validation commands in the contribution guide before submitting
changes, including tests in debug and release builds.
Releases follow the swift-library
[versioning standard](https://github.com/swift-library/.github/blob/master/VERSIONING.md).

## License

swift-userdefault is available under the Apache License 2.0 with the Swift
Runtime Library Exception. See [LICENSE.txt](LICENSE.txt) and [NOTICE](NOTICE).
