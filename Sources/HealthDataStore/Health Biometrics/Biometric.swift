//
//  Biometric.swift
//
//  Created by Kelvin Kosbab on 9/17/22.
//

import Foundation
import HealthKit

// MARK: - Biometric

public  protocol Biometric {
    
    associatedtype UnitofMeasurement: Unit
    
    static var Units: UnitofMeasurement.Type { get }
    
    var healthKitIdentifier: HKQuantityTypeIdentifier { get }
}
