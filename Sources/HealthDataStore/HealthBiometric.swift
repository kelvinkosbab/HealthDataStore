//
//  HealthBiometric.swift
//  Health
//
//  Created by Kelvin Kosbab on 4/3/22.
//

import Foundation
import HealthKit

// MARK: - HealthBiometric

public struct HealthBiometric {
    
    // MARK: - BiometricType
    
    enum BiometricType : Int {
        case quantity = 0
        case category = 1
        case characteristic = 2
        case correlation = 3
        case document = 4
        case workout = 5
    }
    
    // MARK: - Properties
    
    let identifier: String
    let biometricType: BiometricType
    let objectType: HKObjectType
    
    // MARK: - InitError
    
    public enum InitError : Error, LocalizedError {
        case undefinedHKObjectType(identifier: String)
        
        public var errorDescription: String? {
            switch self {
            case .undefinedHKObjectType(identifier: let identifier):
                return "Failed to create a HKObjectType with identifier=\(identifier)"
            }
        }
    }
    
    // MARK: - Public Init
    
    public init(
        identifier: HKQuantityTypeIdentifier
    ) throws {
        try self.init(
            identifier: identifier.rawValue,
            biometricType: .quantity
        )
    }
    
    public init?(
        identifier: HKCategoryTypeIdentifier
    ) throws {
        try self.init(
            identifier: identifier.rawValue,
            biometricType: .category
        )
    }
    
    public init(
        identifier: HKCharacteristicTypeIdentifier
    ) throws {
        try self.init(
            identifier: identifier.rawValue,
            biometricType: .characteristic
        )
    }
    
    public init(
        identifier: HKCorrelationTypeIdentifier
    ) throws {
        try self.init(
            identifier: identifier.rawValue,
            biometricType: .correlation
        )
    }
    
    public init(
        identifier: HKDocumentTypeIdentifier
    ) throws {
        try self.init(
            identifier: identifier.rawValue,
            biometricType: .document
        )
    }
    
    // MARK: - Private Init
    
    private init(
        identifier: String,
        biometricType: BiometricType
    ) throws {
        
        guard let objectType: HKObjectType = {
            switch biometricType {
            case .quantity:
                let identifier = HKQuantityTypeIdentifier(rawValue: identifier)
                return HKObjectType.quantityType(forIdentifier: identifier)
            case .category:
                let identifier = HKCategoryTypeIdentifier(rawValue: identifier)
                return HKObjectType.categoryType(forIdentifier: identifier)
            case .characteristic:
                let identifier = HKCharacteristicTypeIdentifier(rawValue: identifier)
                return HKObjectType.characteristicType(forIdentifier: identifier)
            case .correlation:
                let identifier = HKCorrelationTypeIdentifier(rawValue: identifier)
                return HKObjectType.correlationType(forIdentifier: identifier)
            case .document:
                let identifier = HKDocumentTypeIdentifier(rawValue: identifier)
                return HKObjectType.documentType(forIdentifier: identifier)
            case .workout:
                return HKObjectType.workoutType()
            }
        }() else {
            throw InitError.undefinedHKObjectType(identifier: identifier)
        }
        
        self.init(
            identifier: identifier,
            biometricType: biometricType,
            objectType: objectType)
    }
    
    private init(
        identifier: String,
        biometricType: BiometricType,
        objectType: HKObjectType
    ) {
        self.identifier = identifier
        self.biometricType = biometricType
        self.objectType = objectType
    }
}
