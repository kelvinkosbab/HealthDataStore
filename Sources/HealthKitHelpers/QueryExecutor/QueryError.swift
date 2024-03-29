//
//  QueryError.swift
//
//  Created by Kelvin Kosbab on 10/1/22.
//

import HealthKit

// MARK: - QueryError

/// Defines errors thrown when executing a health query.
public enum QueryError : Error {
    
    /// After a query it is expected to be able to cast to a `HKQuantitySample` type. This error is thrown when the returned
    /// samples do not conform to `HKQuantitySample`.
    case unsupportedSampleType(samples: [HKSample])
    
    /// Throws when a query result quantity type is not compatible with the requested unit.
    case unitIncompatibleWithQuantityType(quantityType: HKQuantityType, desiredUnit: HKUnit)
}
