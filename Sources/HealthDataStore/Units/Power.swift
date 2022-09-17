//
//  Power.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation

// MARK: - Power

/// Deinfes a unit of power.
public struct Power : Unit {
    
    public let stringRepresentation: String
    
    // Watts is the SI unit of power.
    public static let watts = Power(stringRepresentation: "W")
}
