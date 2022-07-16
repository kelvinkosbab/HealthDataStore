//
//  HealthBiometricAuthorization.swift
//  Health
//
//  Created by Kelvin Kosbab on 4/27/22.
//

import Foundation

// MARK: - HealthBiometricAuthorization

@available(macOS 13.0, *)
public struct HealthBiometricAuthorization {
    
    public enum Status : Int {
        case notDetermined = 0
        case denied = 1
        case authorized = 2
    }
    
    public let biometric: HealthBiometric
    public let status: Status
    
    public init(
        biometric: HealthBiometric,
        status: Status
    ) {
        self.biometric = biometric
        self.status = status
    }
}
