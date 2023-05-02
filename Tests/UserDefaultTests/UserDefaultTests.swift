//===--- UserDefaultTests.swift -------------------------------------------===//
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

import XCTest
@testable import UserDefaultUtils

final class UserDefaultTests: XCTestCase {
  
  public enum Keys: String, CaseIterable {
    case model
    case version
    case safetyCheckerDisclaimer
    case computeUnits
  }
  ///
  @UserDefault(key: Keys.model, userDefaults: .standard)
  public var currentModel: ModelInfo! = nil
  ///
  @UserDefault(key: Keys.version, userDefaults: .standard)
  public var version: Int = 0
  ///
  @UserDefault(key: Keys.safetyCheckerDisclaimer)
  public var safetyCheckerDisclaimerRead = false
  ///
  @UserDefault(key: Keys.computeUnits)
  public var systemComputeUnits: ComputeUnits? = .cpuOnly
  ///
  @UserDefault(key: Keys.computeUnits)
  public var preferdComputeUnits: ComputeUnits = ComputeUnits.cpuAndNeuralEngine
  
  var userDefaults: UserDefaults = .init()
  
  override func setUp() async throws {
    flush()
  }
  
  override func tearDown() async throws {
    flush()
  }
  
  func testAnyValueToUserDefaultWrapper() throws {
    var userDefaultValue: Bool? {
      self.userDefaults.object(forKey: Keys.safetyCheckerDisclaimer.rawValue) as? Bool
    }
    XCTAssertFalse(safetyCheckerDisclaimerRead)
    XCTAssertNil(userDefaultValue)
    
    self.safetyCheckerDisclaimerRead = true
    XCTAssertTrue(userDefaultValue!)
    
    userDefaults.set(false, forKey: Keys.safetyCheckerDisclaimer.rawValue)
    XCTAssertEqual(safetyCheckerDisclaimerRead, false)
  }
  
  func testRawRepresentableToUserDefaultWrapper() throws {
    var computeUnits: Int? {
      userDefaults.object(forKey: Keys.computeUnits.rawValue) as? Int
    }
    XCTAssertEqual(preferdComputeUnits, .cpuAndNeuralEngine)
    XCTAssertNil(computeUnits)

    preferdComputeUnits = .cpuOnly
    XCTAssertEqual(computeUnits, ComputeUnits.cpuOnly.rawValue)

    userDefaults.set(ComputeUnits.cpuAndGPU, forKey: Keys.computeUnits.rawValue)
    XCTAssertEqual(preferdComputeUnits, .cpuAndGPU)
  }
  
  func testOptioanlRawRepresentableToUserDefaultWrapper() throws {
    var computeUnits: Int? {
      userDefaults.object(forKey: Keys.computeUnits.rawValue) as? Int
    }
    XCTAssertEqual(systemComputeUnits, .cpuOnly)
    XCTAssertNil(computeUnits)
    
    systemComputeUnits = .cpuOnly
    XCTAssertEqual(computeUnits, ComputeUnits.cpuOnly.rawValue)
    
    userDefaults.set(ComputeUnits.cpuAndGPU, forKey: Keys.computeUnits.rawValue)
    XCTAssertEqual(systemComputeUnits, .cpuAndGPU)
  }

  func testCodableToUserDefaults() throws {
    let modelInfo = modelInfo()
    try userDefaults.set(modelInfo, forKey: Keys.model.rawValue)
    let modelInfo2: ModelInfo? = try userDefaults.object(forKey: Keys.model.rawValue)
    
    XCTAssertEqual(modelInfo, modelInfo2)
  }
  
  func testCodableToUserDefaultWrapper() throws {
    XCTAssertNil(currentModel)
    
    let modelInfo = modelInfo()
    currentModel = modelInfo

    let modelInfo2: ModelInfo? = try userDefaults.object(forKey: Keys.model.rawValue)
    XCTAssertEqual(modelInfo, modelInfo2)
    
    let modelInfo3: ModelInfo! = currentModel
    XCTAssertEqual(modelInfo, modelInfo3)
    
    currentModel = nil
    let modelInfo4: ModelInfo? = try userDefaults.object(forKey: Keys.model.rawValue) ?? nil
    XCTAssertNil(modelInfo4)
    XCTAssertNil(currentModel)
  }
  
  func modelInfo() -> ModelInfo {
    let modelInfo: ModelInfo = .init(
      modelId: "modelPaht/modelId",
      modelVersion: "0.1.0",
      originalAttentionSuffix: "original_compiled",
      splitAttentionSuffix: "split_einsum_compiled",
      supportsEncoder: true)
    return modelInfo
  }
  
  func flush() {
    Keys.allCases.map { $0.rawValue }.forEach(userDefaults.removeObject(forKey:))
  }
}
