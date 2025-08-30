//===--- Codable.swift ----------------------------------------------------===//
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

import Foundation.NSUserDefaults

public extension UserDefaults {
  
  /// Sets the `Codable` value of the specified default key.
  ///
  /// - Parameters:
  ///   - object: The object to store in the defaults database.
  ///   - forKey: The key with which to associate the value.
  /// - Throws: `EncodingError.invalidValue` if a non-conforming floating-point value is encountered during encoding, and the encoding strategy is `.throw`.
  /// An error if any value throws an error during encoding.
  @_spi(Private)
  func set<T: Encodable>(_ value: T?, forKey defaultName: String) throws {
    set(try value.map(JSONEncoder().encode) as Any, forKey: defaultName)
  }
    
  /// Returns the `Codable` object associated with the specified key.
  ///
  /// - Parameters:
  ///   - forKey: A key in the current user‘s defaults database.
  /// - Throws: `DecodingError.dataCorrupted` if values requested from the payload are corrupted, or if the given data is not valid JSON.
  /// An error if any value throws an error during decoding.
  @_spi(Private)
  func object<T: Decodable>(forKey defaultName: String) throws -> T? {
    try data(forKey: defaultName).map { (T.self, $0) }.map(JSONDecoder().decode)
  }
}
