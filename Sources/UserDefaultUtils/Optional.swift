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

extension Optional: RawRepresentable where Wrapped: RawRepresentable {
  
  public var rawValue: Wrapped.RawValue? {
    map { $0.rawValue }
  }
  
  public init?(rawValue: Wrapped.RawValue?) {
    self = rawValue.flatMap(Wrapped.init(rawValue:)).map { .some($0) } ?? .none
  }
}
