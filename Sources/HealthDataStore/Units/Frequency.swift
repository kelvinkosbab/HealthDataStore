//
//  Frequency.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation

// MARK: - Frequency

/// Deinfes a unit of electrical frequency.
public struct Frequency : Unit {
    
    public let stringRepresentation: String
    
    // Hertz is the SI unit of frequency.
    public static let hertz = Frequency(stringRepresentation: "Hz")
}
