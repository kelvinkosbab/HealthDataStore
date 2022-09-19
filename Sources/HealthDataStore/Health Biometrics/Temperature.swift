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
}

// MARK: - QueryExecutor + Temperature

public extension QueryExecutor {
    
    func fetch(
        _ biometric: TemperatureBiometric,
        in unit: TemperatureBiometric.UnitofMeasurement,
        options: QueryOptions
    ) async throws -> [QueryResult] {
        return try await self.fetch(
            healthKitIdentifier: biometric.healthKitIdentifier,
            unit: unit,
            options: options
        )
    }
}

// MARK: - HealthKitAuthorizor + Temperature

public extension HealthKitAuthorizor {
    
    func getRequestStatusForAuthorization(
        toShare typesToShare: Set<TemperatureBiometric>,
        read typesToRead: Set<TemperatureBiometric>
    ) async throws -> HKAuthorizationRequestStatus {
        return try await self.internalGetRequestStatusForAuthorization(toShare: typesToShare, read: typesToRead)
    }
    
    func requestAuthorization(
        toShare typesToShare: Set<TemperatureBiometric>,
        read typesToRead: Set<TemperatureBiometric>
    ) async throws {
        return try await self.internalRequestAuthorization(toShare: typesToShare, read: typesToRead)
    }
}
