//===--- UserDefaultWrapper.swift -----------------------------------------===//
//
// This source file is part of the swift-library open source project
//
// Created by Xudong Xu on 4/23/23.
//
// Copyright (c) 2023 Xudong Xu <showxdxu@gmail.com> and the swift-library project authors
//
// See https://swift-library.github.io/LICENSE.txt for license information
// See https://swift-library.github.io/CONTRIBUTORS.txt for the list of swift-library project authors
// See https://github.com/swift-library for the list of swift-library projects
//
//===----------------------------------------------------------------------===//

import class Foundation.UserDefaults

/// A wrapper that wrap UserDefaults set/get value operations.
public protocol UserDefaultWrapper<Value> {
  
  associatedtype Value
  
  var userDefaults: UserDefaults { get }
  
  /// Set object into UserDefaults, immediately stores a value (or removes the value if nil is passed as the value)
  ///
  /// The value parameter can be only property list objects: `NSData`, `NSString`, `NSNumber`, `NSDate`, `NSArray`, or `NSDictionary`. For `NSArray` and `NSDictionary` objects, their contents must be property list objects. For more information, see What is a Property List? in Property List Programming Guide.
  /// Setting a default has no effect on the value returned by the `object(forKey:)` method if the same key exists in a domain that precedes the application domain in the search list.
  ///
  /// - Parameters:
  ///   - value: The object to store in the defaults database.
  ///   - defaultName: The key with which to associate the value.
  func set(_ value: Value?, forKey defaultName: String)
  
  /// Fetch object from UserDefaults, will search the receiver's search list for a default with the key 'defaultName' and return it.
  ///
  /// This method searches the domains included in the search list in the order in which they are listed and returns the object associated with the first occurrence of the specified default.
  ///
  /// - Parameter defaultName: A key in the current user‘s defaults database.
  /// - Returns: The object associated with the specified key, or nil if the key was not found.
  func object(forKey defaultName: String) -> Value?
}

public extension UserDefaultWrapper where Value: Any {

  /// Sets the value of the specified default key.
  ///
  /// - Parameters:
  ///   - value: The object to store in the defaults database.
  ///   - defaultName: The key with which to associate the value.
  func set(_ value: Value?, forKey defaultName: String) {
    userDefaults.set(value, forKey: defaultName)
  }

  /// Returns the object associated with the specified key.
  ///
  /// - Parameter defaultName: A key in the current user‘s defaults database.
  /// - Returns: The object associated with the specified key, or nil if the key was not found.
  func object(forKey defaultName: String) -> Value? {
    userDefaults.object(forKey: defaultName) as? Value
  }
}

/// FIXME: @showxu use [swift/gyb.py](https://github.com/apple/swift/blob/main/utils/gyb.py) plugin to generate `Float`, `Double`, `Bool`, `URL`
public extension UserDefaultWrapper where Value: RawRepresentable {
  
  /// Sets the value of the specified default key to the specified integer value.
  ///
  /// - Parameters:
  ///   - value: The integer value to store in the defaults database.
  ///   - defaultName: The key with which to associate the value.
  func set(_ value: Value?, forKey defaultName: String) {
    userDefaults.set(value.flatMap { $0 }, forKey: defaultName)
  }
  
  /// Returns the integer value associated with the specified key.
  ///
  /// - Parameter defaultName: A key in the current user‘s defaults database.
  /// - Returns: The integer value associated with the specified key. If the specified key doesn‘t exist, this method returns 0.
  func object(forKey defaultName: String) -> Value? {
    userDefaults.object(forKey: defaultName)
  }
}

public extension UserDefaultWrapper where Value: Encodable {
  
  /// Sets the `Encodable` value of the specified default key.
  ///
  /// - Parameters:
  ///   - object: The object to store in the defaults database.
  ///   - forKey: The key with which to associate the value.
  func set(_ value: Value?, forKey defaultName: String) {
    do {
      try userDefaults.set(value, forKey: defaultName)
    } catch {
      fatalError(error.localizedDescription)
    }
  }
}
  
public extension UserDefaultWrapper where Value: Decodable {
  
  /// Returns the `Decodable` object associated with the specified key.
  ///
  /// - Parameters:
  ///   - forKey: A key in the current user‘s defaults database.
  func object(forKey defaultName: String) -> Value? {
    do {
      return try userDefaults.object(forKey: defaultName)
    } catch {
      fatalError(error.localizedDescription)
    }
  }
}
