//
//  Temperature.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation

// MARK: - Temperature

/// Deinfes a unit of temperature.
public struct Temperature : Unit {
    
    public let stringRepresentation: String
    
    // Kelvin is the SI unit of temperature.
    public static let kelvin = Temperature(stringRepresentation: "K")
    public static let celsius = Temperature(stringRepresentation: "degC")
    public static let fahrenheit = Temperature(stringRepresentation: "degF")
}
