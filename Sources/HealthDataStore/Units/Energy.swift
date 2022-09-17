//
//  Energy.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation

// MARK: - Energy

/// Deinfes a unit of energy.
public struct Energy : Unit {
    
    public let stringRepresentation: String
    
    /// Joules is the SI unit of energy/
    public static let joules = Energy(stringRepresentation: "joules")
    public static let cal = Energy(stringRepresentation: "cal")
    public static let kcal = Energy(stringRepresentation: "kcal")
}
