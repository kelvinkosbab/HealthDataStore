//
//  QueryResult.swift
//  Health
//
//  Created by Kelvin Kosbab on 8/3/22.
//

import Foundation
import HealthKit

// MARK: - QueryResult

struct QueryResult {
    
    enum Values {
        case noUnitProvidedInQuery
        case values(_ values: [Double], unit: HKUnit)
    }
    
    let samples: [HKQuantitySample]
    let values: Values
}
