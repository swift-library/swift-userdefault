//===--- Optional.swift ---------------------------------------------------===//
//
// This source file is part of the swift-library open source project
//
// Created by Xudong Xu on 5/2/23.
//
// Copyright (c) 2023 Xudong Xu <showxdxu@gmail.com> and the swift-library project authors
//
// See https://swift-library.github.io/LICENSE.txt for license information
// See https://swift-library.github.io/CONTRIBUTORS.txt for the list of swift-library project authors
// See https://github.com/swift-library for the list of swift-library projects
//
//===----------------------------------------------------------------------===//

@_exported import UserDefault

/// Makes an optional of a `RawRepresentable` type `RawRepresentable`, so
/// `UserDefault` stores an optional enumeration as its raw value.
///
/// The raw value of `nil` is `nil`, and the raw value of a wrapped value is
/// the wrapped value's raw value.
extension Swift.Optional: Swift.RawRepresentable where Wrapped: RawRepresentable {
  
  public var rawValue: Wrapped.RawValue? {
    map { $0.rawValue }
  }
  
  /// Creates an optional from a raw value.
  ///
  /// A `nil` raw value creates `nil`. A raw value that `Wrapped(rawValue:)`
  /// rejects makes this initializer fail, so `UserDefault` reads the
  /// property's default value instead of `nil`.
  ///
  /// - Parameter rawValue: The raw value of the wrapped value, or `nil`.
  public init?(rawValue: Wrapped.RawValue?) {
    guard let rawValue else {
      self = .none
      return
    }
    guard let wrapped = Wrapped(rawValue: rawValue) else {
      return nil
    }
    self = .some(wrapped)
  }
}
