//===--- RawRepresentable.swift -------------------------------------------===//
//
// This source file is part of the swift-library open source project
//
// Created by Xudong Xu on 5/1/23.
//
// Copyright (c) 2023 Xudong Xu <showxdxu@gmail.com> and the swift-library project authors
//
// See https://swift-library.github.io/LICENSE.txt for license information
// See https://swift-library.github.io/CONTRIBUTORS.txt for the list of swift-library project authors
// See https://github.com/swift-library for the list of swift-library projects
//
//===----------------------------------------------------------------------===//

import class Foundation.UserDefaults

/// FIXME: @showxu use [swift/gyb.py](https://github.com/apple/swift/blob/main/utils/gyb.py) plugin to generate `String`, `Float`, `Double`, `Bool`, `URL`
public extension UserDefaults {
  
  /// Sets the value of the specified default key to the specified integer value.
  ///
  /// - Parameters:
  ///   - value: The rawValue of `RawRepresentable` to store in the defaults database.
  ///   - defaultName: The key with which to associate the value.
  func set<T>(_ value: T?, forKey defaultName: String) where T: RawRepresentable {
    set(value?.rawValue as Any, forKey: defaultName)
  }
  
  /// Returns the `RawRepresentable` with rawValue associated with the specified key.
  ///
  /// - Parameter defaultName: A key in the current user‘s defaults database.
  /// - Returns: The integer value associated with the specified key. If the specified key doesn‘t exist, this method returns 0.
  func object<T>(forKey defaultName: String) -> T? where T: RawRepresentable {
    /// In case of `nil as? Optional<Optional<T.RawValue>>` will produce `Optional<Optional<nil>>`
    guard let value = object(forKey: defaultName) else {
      return nil
    }
    return (value as? T.RawValue).flatMap(T.init(rawValue:))
  }
}
