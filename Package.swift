// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "swift-userdefault",
  platforms: [.macOS(.v10_13), .iOS(.v11), .tvOS(.v11), .watchOS(.v4)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "UserDefault",
      targets: [
        "UserDefault",
        "UserDefaultUtils",
      ]),
    
    .library(
      name: "DynamicUserDefault",
      type: .dynamic,
      targets: [
        "UserDefault",
        "UserDefaultUtils",
      ]),
  ],
  dependencies: [
    .package(url: "https://github.com/swift-library/swift-gyb", from: "0.0.1"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "UserDefaultUtils", dependencies: ["UserDefault"]),
    
    .target(
      name: "UserDefault",
      plugins: [.plugin(name: "Gyb", package: "swift-gyb")]),
    
    .testTarget(
      name: "UserDefaultTests",
      dependencies: [
        "UserDefault",
        "UserDefaultUtils"
      ]),
  ]
)
