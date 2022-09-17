//
//  Temperature.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation
import HealthKit

// MARK: - Temperature

/// Deinfes a unit of temperature.
public enum Temperature : String, Unit {
    
    // Kelvin is the SI unit of temperature.
    case kelvin = "K"
    case celsius = "degC"
    case fahrenheit = "degF"
    
    var healthKitUnit: HKUnit {
        switch self {
        case .kelvin:
            return HKUnit.kelvin()
        case .celsius:
            return HKUnit.degreeCelsius()
        case .fahrenheit:
            return HKUnit.degreeFahrenheit()
        }
    }
}
