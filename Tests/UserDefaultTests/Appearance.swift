//===--- Appearance.swift -------------------------------------------------===//
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

/// A type that is both `RawRepresentable` and `Codable`.
public enum Appearance: String, Codable {
  case light
  case dark
}
