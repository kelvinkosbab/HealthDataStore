//
//  Time.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation

// MARK: - Time

/// Deinfes a unit of time.
public struct Time : Unit {
    
    public let stringRepresentation: String
    
    /// Seconds is the SI unit of time.
    public static let seconds = Time(stringRepresentation: "s")
    public static let minutes = Time(stringRepresentation: "min")
    public static let hours = Time(stringRepresentation: "hr")
    public static let days = Time(stringRepresentation: "d")
}
