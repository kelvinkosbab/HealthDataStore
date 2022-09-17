//
//  ElectricalPotentialDifference.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation

// MARK: - Electric Potential Difference

/// Deinfes a unit of electric potential difference.
public struct ElectricalPotentialDifference : Unit {
    
    public let stringRepresentation: String
    
    // Volts is the SI unit of electric potential.
    public static let volts = ElectricalPotentialDifference(stringRepresentation: "V")
}
