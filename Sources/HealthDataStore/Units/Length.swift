//
//  Length.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation
import HealthKit

// MARK: - Length

/// Deinfes a unit of length.
public enum Length : String, Unit {
    
    public var stringRepresentation: String {
        return self.rawValue
    }
    
    // MARK: - Metric Units
    
    /// Meteres is the SI unit of length.
    case meters = "m"
    case centimeters = "cm"
    case millimeters = "mm"
    case kilometers = "km"
    
    // MARK: - Imperial Units
    
    case inches = "in"
    case feet = "ft"
    case yard = "yd"
    case miles = "mi"
    
    var hkUnit: HKUnit {
        switch self {
        case .meters:
            return HKUnit.meter()
        case .centimeters:
            return HKUnit.meterUnit(with: .centi)
        case .millimeters:
            return HKUnit.meterUnit(with: .milli)
        case .kilometers:
            return HKUnit.meterUnit(with: .kilo)
            
        case .inches:
            return HKUnit.inch()
        case .feet:
            return HKUnit.foot()
        case .yard:
            return HKUnit.yard()
        case .miles:
            return HKUnit.mile()
        }
    }
}
