//
//  Mass.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation

// MARK: - Mass

/// Defines a unit of mass.
public struct Mass : Unit {
    
    public let stringRepresentation: String
    
    /// Grams is the SI unit of mass.
    public static let grams = Mass(stringRepresentation: "g")
    public static let ounces = Mass(stringRepresentation: "oz")
    public static let pounds = Mass(stringRepresentation: "lb")
    public static let stones = Mass(stringRepresentation: "st")
    public static let moles = Mass(stringRepresentation: "mol")
}
