//
//  Temperature.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation
import HealthKit

// MARK: - Temperature

/// Deinfes a unit of temperature.
public enum Temperature : String, Unit {
    
    // Kelvin is the SI unit of temperature.
    case kelvin = "K"
    case celsius = "degC"
    case fahrenheit = "degF"
    
    var healthKitUnit: HKUnit {
        switch self {
        case .kelvin:
            return HKUnit.kelvin()
        case .celsius:
            return HKUnit.degreeCelsius()
        case .fahrenheit:
            return HKUnit.degreeFahrenheit()
        }
    }
}

// MARK: - TemperatureBiometric

public struct TemperatureBiometric : Biometric {
    
    public static let Units = Temperature.self
    
    public let healthKitIdentifier: HKQuantityTypeIdentifier
    
    /// A quantity sample type that measures the user’s body temperature.
    ///
    /// These samples use temperature units (described in `HKUnit`) and measure discrete values (described in `HKStatisticsQuery`).
    public static let bodyTemperature = Self(healthKitIdentifier: .bodyTemperature)
    
    /// A quantity sample type that measures the user’s sleeping wrist temperature temperature.
    @available(iOS 16.0, *)
    public static let appleSleepingWristTemperature = Self(healthKitIdentifier: .appleSleepingWristTemperature)
}

// MARK: - QueryExecutor + Temperature

public extension QueryExecutor {
    
    func fetch(
        _ biometric: TemperatureBiometric,
        in unit: TemperatureBiometric.UnitofMeasurement,
        options: QueryOptions
    ) async throws -> [Sample] {
        return try await self.query(
            identifier: biometric.healthKitIdentifier,
            unit: unit,
            options: options
        )
    }
}

// MARK: - BackgroundDelivery + TemperatureBiometric

public extension BackgroundDeliveryEnabler {
    
    func enableBackgroundDelivery(
        for type: TemperatureBiometric,
        frequency: HKUpdateFrequency
    ) async throws {
        let biometric = try CodableHealthBiometric(identifier: type.healthKitIdentifier)
        try await self.enableBackgroundDelivery(for: biometric.sampleType, frequency: frequency)
    }
    
    func disableBackgroundDelivery(
        for type: TemperatureBiometric
    ) async throws {
        let biometric = try CodableHealthBiometric(identifier: type.healthKitIdentifier)
        try await self.disableBackgroundDelivery(for: biometric.sampleType)
    }
}
