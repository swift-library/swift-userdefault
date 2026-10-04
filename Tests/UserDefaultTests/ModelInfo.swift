//===--- ModelInfo.swift --------------------------------------------------===//
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

struct ModelInfo: Codable, Equatable {
  /// Hugging Face model Id that contains .zip archives with compiled Core ML models
  let modelId: String
  
  /// Arbitrary string for presentation purposes. Something like "2.1-base"
  let modelVersion: String
  
  /// Suffix of the archive containing the ORIGINAL attention variant. Usually something like "original_compiled"
  let originalAttentionSuffix: String
  
  /// Suffix of the archive containing the SPLIT_EINSUM attention variant. Usually something like "split_einsum_compiled"
  let splitAttentionSuffix: String
  
  /// Whether the archive contains the VAE Encoder (for image to image tasks). Not yet in use.
  let supportsEncoder: Bool
}
