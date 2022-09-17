//
//  Angle.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation

// MARK: - Angle

/// Deinfes a unit of electrical frequency.
public struct Angle : Unit {
    
    public let stringRepresentation: String
    
    /// Radians is the SI unit of angle measurements.
    public static let radians = Angle(stringRepresentation: "rad")
}
