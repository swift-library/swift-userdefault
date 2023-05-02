//===--- ComputeUnits.swift -----------------------------------------------===//
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

public enum ComputeUnits: Int, @unchecked Sendable {
  case cpuOnly = 0
  case cpuAndGPU = 1
  case all = 2
  case cpuAndNeuralEngine = 3
}
