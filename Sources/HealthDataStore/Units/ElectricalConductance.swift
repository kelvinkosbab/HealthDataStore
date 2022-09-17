//
//  ElectricalConductance.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation

// MARK: - Electrical Conductance

/// Deinfes a unit of electrical conductance.
public struct ElectricalConductance : Unit {
    
    public let stringRepresentation: String
    
    /// Siemens is the SI unit of electical conductance.
    public static let siemens = ElectricalConductance(stringRepresentation: "S")
}
