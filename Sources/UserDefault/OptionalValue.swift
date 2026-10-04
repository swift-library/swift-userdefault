//===--- OptionalValue.swift ----------------------------------------------===//
//
// This source file is part of the swift-library open source project
//
// Created by Xudong Xu on 10/4/26.
//
// Copyright (c) 2026 Xudong Xu <showxdxu@gmail.com> and the swift-library project authors
//
// See https://swift-library.github.io/LICENSE.txt for license information
// See https://swift-library.github.io/CONTRIBUTORS.txt for the list of swift-library project authors
// See https://github.com/swift-library for the list of swift-library projects
//
//===----------------------------------------------------------------------===//

import class Foundation.UserDefaults

/// An `Optional` whose wrapped type is erased, so generic code can find `nil`
/// inside a value whose type may itself be optional.
protocol OptionalValue {
  var wrappedAny: Any? { get }
}

extension Optional: OptionalValue {
  var wrappedAny: Any? { map { $0 } }
}

/// Returns the value inside every level of optional nesting, or `nil` when
/// any level is `nil`.
func unwrapped(_ value: Any?) -> Any? {
  guard let value else { return nil }
  guard let optional = value as? OptionalValue else { return value }
  return unwrapped(optional.wrappedAny)
}

extension UserDefaults {
  
  /// Stores a property list value, or removes the key when the value is `nil`
  /// at any level of optional nesting.
  ///
  /// A generic `T?` whose `T` is itself optional converts to `Any?` as
  /// `.some(nil)`, which `UserDefaults` rejects as a non-property-list object.
  ///
  /// - Parameters:
  ///   - value: The property list value to store, or `nil` to remove the key.
  ///   - defaultName: The key with which to associate the value.
  func setPropertyListValue(_ value: Any?, forKey defaultName: String) {
    if let value = unwrapped(value) {
      set(value, forKey: defaultName)
    } else {
      removeObject(forKey: defaultName)
    }
  }
}
