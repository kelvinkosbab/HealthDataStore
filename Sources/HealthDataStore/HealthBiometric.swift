//
//  HealthBiometric.swift
//  Health
//
//  Created by Kelvin Kosbab on 4/3/22.
//

import Foundation
import HealthKit

// MARK: - HealthBiometricType

/// An abstract type for all classes that identify a specific type of sample when working with the HealthKit store.
///
/// https://developer.apple.com/documentation/healthkit/hksampletype
enum HealthBiometricType : Int {
    
    /// A type that identifies samples that store numerical values.
    ///
    /// https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier
    case quantity = 0
    
    /// A type that identifies samples that contain a value from a small set of possible values.
    ///
    /// https://developer.apple.com/documentation/healthkit/hkcategorytypeidentifier
    case category = 1
    
    /// A type that identifies samples that group multiple subsamples.
    ///
    /// https://developer.apple.com/documentation/healthkit/hkcorrelationtypeidentifier
    case correlation = 2
    
    /// The identifiers for documents.
    ///
    /// https://developer.apple.com/documentation/healthkit/hkdocumenttypeidentifier
    case document = 3
    
    /// A type that identifies samples that store information about a workout.
    ///
    /// https://developer.apple.com/documentation/healthkit/hkworkouttype
    case workout = 4
}

// MARK: - HealthBiometric

public struct HealthBiometric {
    
    // MARK: - Properties
    
    let identifier: String
    let biometricType: HealthBiometricType
    let sampleType: HKSampleType
    
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
        biometricType: HealthBiometricType
    ) throws {
        switch biometricType {
        case .quantity:
            let sampleIdentifier = HKQuantityTypeIdentifier(rawValue: identifier)
            let sampleType = HKObjectType.quantityType(forIdentifier: sampleIdentifier)
            try self.init(
                identifier: identifier,
                biometricType: biometricType,
                sampleType: sampleType
            )
        case .category:
            let sampleIdentifier = HKCategoryTypeIdentifier(rawValue: identifier)
            let sampleType = HKObjectType.categoryType(forIdentifier: sampleIdentifier)
            try self.init(
                identifier: identifier,
                biometricType: biometricType,
                sampleType: sampleType
            )
        case .correlation:
            let sampleIdentifier = HKCorrelationTypeIdentifier(rawValue: identifier)
            let sampleType = HKObjectType.correlationType(forIdentifier: sampleIdentifier)
            try self.init(
                identifier: identifier,
                biometricType: biometricType,
                sampleType: sampleType
            )
        case .document:
            let sampleIdentifier = HKDocumentTypeIdentifier(rawValue: identifier)
            let sampleType = HKObjectType.documentType(forIdentifier: sampleIdentifier)
            try self.init(
                identifier: identifier,
                biometricType: biometricType,
                sampleType: sampleType
            )
        case .workout:
            try self.init(
                identifier: identifier,
                biometricType: biometricType,
                sampleType: HKObjectType.workoutType()
            )
        }
    }
    
    private init(
        identifier: String,
        biometricType: HealthBiometricType,
        sampleType: HKSampleType?
    ) throws {
        
        guard let sampleType else {
            throw InitError.undefinedHKObjectType(identifier: identifier)
        }
        
        self.identifier = identifier
        self.biometricType = biometricType
        self.sampleType = sampleType
    }
}
