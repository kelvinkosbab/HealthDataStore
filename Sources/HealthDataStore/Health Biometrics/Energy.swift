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
    
    /// The kilocalorie is used to measure food energy in many regions.
    case kcal = "kcal"
    
    /// The large calorie is the same as a kilocalorie (1 Cal = 4184.0 J).
    case largeCal = "largeCalorie"
    
    /// This unit represents the gram calorie, or the amount of energy needed to raise 1 gram of
    /// water by 1 degree Celsius (1 cal = 4.1840 J).
    ///
    /// This unit is occasionally used in chemistry and other sciences, but it should not be confused with the kilocalorie,
    /// or large calorie, which is used for measuring food energy in many regions.
    case smallCal = "smallCalorie"
    
    var healthKitUnit: HKUnit {
        switch self {
        case .joules:
            return HKUnit.joule()
        case .kcal:
            return HKUnit.kilocalorie()
        case .largeCal:
            return HKUnit.largeCalorie()
        case .smallCal:
            return HKUnit.smallCalorie()
        }
    }
}
