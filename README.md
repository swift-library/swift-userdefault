# Swift UserDefault

The property wrapper implementation for `Foundation.UserDefaults`.

## Usage

**Code Example**

```swift
class Settings {
  public enum Keys: String, CaseIterable {
    case model
    case version
    case safetyCheckerDisclaimer
    case computeUnits
  }
  
  @UserDefault(key: Keys.model, userDefaults: .standard)
  public var currentModel: ModelInfo! = nil

  @UserDefault(key: Keys.version, userDefaults: .standard)
  public var version: Int = 0
  
  @UserDefault(key: Keys.safetyCheckerDisclaimer)
  public var safetyCheckerDisclaimerRead = false
  
  @UserDefault(key: Keys.computeUnits)
  public var systemComputeUnits: ComputeUnits? = .cpuOnly
}
```

## Adding `swift-userdefault` as a Dependency

To use the `swift-userdefault` library in a SwiftPM project, 
add it to the dependencies for your package and your target:

```swift
let package = Package(
  // name, platforms, products, etc.
  dependencies: [
    // other dependencies
    .package(url: "https://github.com/swift-library/swift-userdefault", from: "0.0.1"),
  ],
  targets: [
    .executableTarget(
      name: "<command-line-tool>",
      dependencies: [
        // other dependencies
        .product(name: "UserDefault", package: "swift-userdefault"),
      ],
      plugins: [
        // other dependencies
      ]
    ),
    // other targets
  ]
)
```

### Supported Versions

The most recent versions of swift-userdefault support Swift 5.8 and newer. The minimum Swift version supported by swift-userdefault releases are detailed below:

swift-userdefault | Minimum Swift Version
----------|----------------------
`0.0.1`   | 5.8

<!-- Link references for readme -->

[swift]: https://github.com/apple/swift
