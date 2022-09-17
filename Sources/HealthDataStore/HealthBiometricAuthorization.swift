//
//  HealthBiometricAuthorization.swift
//  Health
//
//  Created by Kelvin Kosbab on 4/27/22.
//

import Foundation
import HealthKit

// MARK: - HealthBiometricAuthorization

@available(macOS 13.0, *)
public struct HealthBiometricAuthorization {
    
    public enum Status : Int {
        case notDetermined = 0
        case denied = 1
        case authorized = 2
    }
    
    let biometric: CodableHealthBiometric
    public let status: Status
    
    public init(
        identifier: HKQuantityTypeIdentifier,
        status: Status
    ) throws {
        self.biometric = try CodableHealthBiometric(identifier: identifier)
        self.status = status
    }
    
    public init?(
        identifier: HKCategoryTypeIdentifier,
        status: Status
    ) throws {
        self.biometric = try CodableHealthBiometric(identifier: identifier)
        self.status = status
    }
    
    public init(
        identifier: HKCorrelationTypeIdentifier,
        status: Status
    ) throws {
        self.biometric = try CodableHealthBiometric(identifier: identifier)
        self.status = status
    }
    
    public init(
        identifier: HKDocumentTypeIdentifier,
        status: Status
    ) throws {
        self.biometric = try CodableHealthBiometric(identifier: identifier)
        self.status = status
    }
}
