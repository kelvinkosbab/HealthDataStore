//
//  ElectricalPotentialDifference.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation
import HealthKit

// MARK: - Electric Potential Difference

/// Deinfes a unit of electric potential difference.
public enum ElectricalPotentialDifference : String, Unit {
    
    // Volts is the SI unit of electric potential.
    case volts = "V"
    
    var healthKitUnit: HKUnit {
        switch self {
        case .volts:
            return HKUnit.volt()
        }
    }
}
