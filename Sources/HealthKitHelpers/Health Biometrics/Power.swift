//
//  Power.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation
import HealthKit

// MARK: - Power

/// Deinfes a unit of power.
@available(iOS 16.0, *)
public enum Power : String, Unit {
    
    // Watts is the SI unit of power.
    case watts = "W"
    
    var healthKitUnit: HKUnit {
        switch self {
        case .watts:
            return HKUnit.watt()
        }
    }
}
