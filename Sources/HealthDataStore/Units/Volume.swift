//
//  Volume.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation

// MARK: - Volume

/// Deinfes a unit of volume.
public struct Volume : Unit {
    
    public let stringRepresentation: String
    
    /// Liters is the SI unit of volume.
    public static let liters = Volume(stringRepresentation: "L")
    public static let usFluidOunces = Volume(stringRepresentation: "fl_oz_us")
    public static let ImperialFluidOunces = Volume(stringRepresentation: "fl_oz_imp")
    public static let usPint = Volume(stringRepresentation: "pt_us")
    public static let imperialPint = Volume(stringRepresentation: "pt_imp")
    public static let usCup = Volume(stringRepresentation: "cup_us")
    public static let imperialCup = Volume(stringRepresentation: "cup_imp")
}
