//
//  HealthBiometricTests.swift
//
//  Created by Kelvin Kosbab on 6/26/22.
//

import XCTest
@testable import HealthDataStore

// MARK: - HealthBiometricTests

@available(macOS 13.0, *)
class HealthBiometricTests : XCTestCase {
    
    /// Tests the expected raw values of `HealthBiometric.Type`. These values should not change.
    func testHealthBiometricTypeTests() {
        XCTAssert(HealthBiometricType.quantity.rawValue == 0)
        XCTAssert(HealthBiometricType.category.rawValue == 1)
        XCTAssert(HealthBiometricType.correlation.rawValue == 2)
        XCTAssert(HealthBiometricType.document.rawValue == 3)
        XCTAssert(HealthBiometricType.workout.rawValue == 4)
    }
    
    /// Tests a single HealthKit quantity type biometirc to insure it correctly maps in the `HealthBiometric` type.
    func testHKQuantityTypeIdentifierBiometrics() {
        let bodyMassIndex = try? HealthBiometric(identifier: .bodyMassIndex)
        XCTAssert(bodyMassIndex?.identifier == "HKQuantityTypeIdentifierBodyMassIndex")
        XCTAssert(bodyMassIndex?.biometricType == .quantity)
    }
    
    /// Tests a single HealthKit category type biometirc to insure it correctly maps in the `HealthBiometric` type.
    func testHKCategoryTypeIdentifierBiometrics() {
        let bodyMassIndex = try? HealthBiometric(identifier: .sleepAnalysis)
        XCTAssert(bodyMassIndex?.identifier == "HKCategoryTypeIdentifierSleepAnalysis")
        XCTAssert(bodyMassIndex?.biometricType == .category)
    }
}
