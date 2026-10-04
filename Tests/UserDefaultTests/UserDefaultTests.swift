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
@_spi(Private) import UserDefault
import UserDefaultUtils

final class UserDefaultTests: XCTestCase {
  
  static let suiteName = "swift-userdefault.UserDefaultTests"
  static let userDefaults = UserDefaults(suiteName: suiteName)!
  
  public enum Keys: String {
    case model
    case version
    case safetyCheckerDisclaimer
    case computeUnits
    case nickname
  }
  ///
  @UserDefault(key: Keys.model, userDefaults: UserDefaultTests.userDefaults)
  public var currentModel: ModelInfo! = nil
  ///
  @UserDefault(key: Keys.version, userDefaults: UserDefaultTests.userDefaults)
  public var version: Int = 0
  ///
  @UserDefault(key: Keys.safetyCheckerDisclaimer, userDefaults: UserDefaultTests.userDefaults)
  public var safetyCheckerDisclaimerRead = false
  ///
  @UserDefault(key: Keys.computeUnits, userDefaults: UserDefaultTests.userDefaults)
  public var systemComputeUnits: ComputeUnits? = .cpuOnly
  ///
  @UserDefault(key: Keys.computeUnits, userDefaults: UserDefaultTests.userDefaults)
  public var preferredComputeUnits: ComputeUnits = ComputeUnits.cpuAndNeuralEngine
  ///
  @UserDefault(key: Keys.nickname, userDefaults: UserDefaultTests.userDefaults)
  public var nickname: String? = "Guest"
  ///
  @UserDefault(key: Keys.model, userDefaults: UserDefaultTests.userDefaults)
  public var requiredModel: ModelInfo = UserDefaultTests.defaultModel
  
  static let defaultModel = ModelInfo(
    modelId: "default/modelId",
    modelVersion: "0.0.0",
    originalAttentionSuffix: "original",
    splitAttentionSuffix: "split_einsum",
    supportsEncoder: false)
  
  var userDefaults: UserDefaults { Self.userDefaults }
  
  override func setUp() {
    super.setUp()
    userDefaults.removePersistentDomain(forName: Self.suiteName)
  }
  
  override func tearDown() {
    userDefaults.removePersistentDomain(forName: Self.suiteName)
    super.tearDown()
  }
  
  func testAnyValueToUserDefaultWrapper() throws {
    var userDefaultValue: Bool? {
      userDefaults.object(forKey: Keys.safetyCheckerDisclaimer.rawValue) as? Bool
    }
    XCTAssertFalse(safetyCheckerDisclaimerRead)
    XCTAssertNil(userDefaultValue)
    
    safetyCheckerDisclaimerRead = true
    XCTAssertEqual(userDefaultValue, true)
    
    userDefaults.set(false, forKey: Keys.safetyCheckerDisclaimer.rawValue)
    XCTAssertEqual(safetyCheckerDisclaimerRead, false)
  }
  
  func testIntValueToUserDefaultWrapper() throws {
    XCTAssertEqual(version, 0)
    
    version = 2
    XCTAssertEqual(userDefaults.object(forKey: Keys.version.rawValue) as? Int, 2)
    
    userDefaults.set(3, forKey: Keys.version.rawValue)
    XCTAssertEqual(version, 3)
  }
  
  func testRawRepresentableToUserDefaultWrapper() throws {
    var computeUnits: Int? {
      userDefaults.object(forKey: Keys.computeUnits.rawValue) as? Int
    }
    XCTAssertEqual(preferredComputeUnits, .cpuAndNeuralEngine)
    XCTAssertNil(computeUnits)

    preferredComputeUnits = .cpuOnly
    XCTAssertEqual(computeUnits, ComputeUnits.cpuOnly.rawValue)

    userDefaults.set(ComputeUnits.cpuAndGPU, forKey: Keys.computeUnits.rawValue)
    XCTAssertEqual(preferredComputeUnits, .cpuAndGPU)
  }
  
  func testOptionalRawRepresentableToUserDefaultWrapper() throws {
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
    XCTAssertNil(userDefaults.object(forKey: Keys.model.rawValue))
    XCTAssertNil(currentModel)
  }
  
  func testAssigningNilToOptionalRawRepresentableRemovesKey() throws {
    systemComputeUnits = .cpuAndGPU
    XCTAssertEqual(
      userDefaults.object(forKey: Keys.computeUnits.rawValue) as? Int,
      ComputeUnits.cpuAndGPU.rawValue)
    
    systemComputeUnits = nil
    XCTAssertNil(userDefaults.object(forKey: Keys.computeUnits.rawValue))
    XCTAssertEqual(systemComputeUnits, .cpuOnly)
  }
  
  func testAssigningNilToOptionalCodableRemovesKey() throws {
    nickname = "Ada"
    XCTAssertNotNil(userDefaults.data(forKey: Keys.nickname.rawValue))
    XCTAssertEqual(nickname, "Ada")
    
    nickname = nil
    XCTAssertNil(userDefaults.object(forKey: Keys.nickname.rawValue))
    XCTAssertEqual(nickname, "Guest")
  }
  
  func testUndecodableDataReadsDefaultValue() throws {
    let key = Keys.model.rawValue
    requiredModel = modelInfo()
    XCTAssertEqual(requiredModel, modelInfo())
    
    userDefaults.set(Data("not json".utf8) as Any, forKey: key)
    XCTAssertEqual(requiredModel, Self.defaultModel)
    XCTAssertNil(currentModel)
    XCTAssertThrowsError(try userDefaults.object(forKey: key) as ModelInfo?)
    
    userDefaults.set(Data(#"{"modelId":1}"#.utf8) as Any, forKey: key)
    XCTAssertEqual(requiredModel, Self.defaultModel)
    XCTAssertNil(currentModel)
    
    userDefaults.set("not data" as Any, forKey: key)
    XCTAssertEqual(requiredModel, Self.defaultModel)
    XCTAssertNil(currentModel)
    
    userDefaults.set(Data("[1, 2]".utf8) as Any, forKey: Keys.nickname.rawValue)
    XCTAssertEqual(nickname, "Guest")
  }
  
  func testSettingNilRemovesKey() throws {
    let rawValueKey = "rawValue"
    userDefaults.set(ComputeUnits.all, forKey: rawValueKey)
    XCTAssertNotNil(userDefaults.object(forKey: rawValueKey))
    userDefaults.set(nil as ComputeUnits?, forKey: rawValueKey)
    XCTAssertNil(userDefaults.object(forKey: rawValueKey))
    
    let codableKey = "codable"
    try userDefaults.set(modelInfo(), forKey: codableKey)
    XCTAssertNotNil(userDefaults.object(forKey: codableKey))
    try userDefaults.set(nil as ModelInfo?, forKey: codableKey)
    XCTAssertNil(userDefaults.object(forKey: codableKey))
  }
  
  func modelInfo() -> ModelInfo {
    let modelInfo: ModelInfo = .init(
      modelId: "modelPath/modelId",
      modelVersion: "0.1.0",
      originalAttentionSuffix: "original_compiled",
      splitAttentionSuffix: "split_einsum_compiled",
      supportsEncoder: true)
    return modelInfo
  }
}
