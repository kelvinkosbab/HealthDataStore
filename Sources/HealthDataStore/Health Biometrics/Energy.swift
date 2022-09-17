//
//  Energy.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation
import HealthKit

// MARK: - Energy

/// Deinfes a unit of energy.
public enum Energy : String, Unit {
    
    /// Joules is the SI unit of energy/
    case joules = "joules"
    case cal = "cal"
    case kcal = "kcal"
    
    var healthKitUnit: HKUnit {
        switch self {
        case .joules:
            return HKUnit.joule()
        case .cal:
            return HKUnit.smallCalorie()
        case .kcal:
            return HKUnit.largeCalorie()
        }
    }
}
