//
//  Pressure.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation

// MARK: - Pressure

/// Deinfes a unit of pressure.
public struct Pressure : Unit {
    
    public let stringRepresentation: String
    
    /// Pascals is the SI unit of pressure.
    public static let pascals = Pressure(stringRepresentation: "Pa")
    public static let mmHg = Pressure(stringRepresentation: "mmHg")
    public static let cmAq = Pressure(stringRepresentation: "cmAq")
    public static let atm = Pressure(stringRepresentation: "atm")
    public static let dBASPL = Pressure(stringRepresentation: "Pa")
    public static let inHg = Pressure(stringRepresentation: "inHg")
}
