//
//  Time.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation
import HealthKit

// MARK: - Time

/// Deinfes a unit of time.
public enum Time : String, Unit {
    
    /// Seconds is the SI unit of time.
    case seconds = "s"
    case minutes = "min"
    case hours = "hr"
    case days = "d"
    
    var healthKitUnit: HKUnit {
        switch self {
        case .seconds:
            return HKUnit.second()
        case .minutes:
            return HKUnit.minute()
        case .hours:
            return HKUnit.hour()
        case .days:
            return HKUnit.day()
        }
    }
}
