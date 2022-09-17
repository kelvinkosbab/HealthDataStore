//
//  Length.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation
import HealthKit

// MARK: - Length

/// Deinfes a unit of length.
public enum Length : String, Unit {
    
    // MARK: - Metric Units
    
    /// Meteres is the SI unit of length.
    case meters = "m"
    case centimeters = "cm"
    case millimeters = "mm"
    case kilometers = "km"
    
    // MARK: - Imperial Units
    
    case inches = "in"
    case feet = "ft"
    case yard = "yd"
    case miles = "mi"
    
    var healthKitUnit: HKUnit {
        switch self {
        case .meters:
            return HKUnit.meter()
        case .centimeters:
            return HKUnit.meterUnit(with: .centi)
        case .millimeters:
            return HKUnit.meterUnit(with: .milli)
        case .kilometers:
            return HKUnit.meterUnit(with: .kilo)
            
        case .inches:
            return HKUnit.inch()
        case .feet:
            return HKUnit.foot()
        case .yard:
            return HKUnit.yard()
        case .miles:
            return HKUnit.mile()
        }
    }
}

// MARK: - LengthBiometric

public struct LengthBiometric : Biometric {
    
    public static let Units = Length.self
    
    public let healthKitIdentifier: HKQuantityTypeIdentifier
    
    /// A quantity sample type that measures the distance the user has moved by cycling.
    ///
    /// These samples use length units (described in `HKUnit`) and measure cumulative values (described in `HKStatisticsQuery`).
    public static let distanceCycling = LengthBiometric(healthKitIdentifier: .distanceCycling)
    
    /// A quantity sample type that measures the distance the user has moved while swimming.
    ///
    /// These samples use length units (described in `HKUnit`) and measure cumulative values (described in `HKStatisticsQuery`).
    public static let distanceSwimming = LengthBiometric(healthKitIdentifier: .distanceSwimming)

    /// A quantity sample type that measures the distance the user has moved by walking or running.
    ///
    /// These samples use length units (described in `HKUnit`) and measure cumulative values (described in `HKStatisticsQuery`).
    public static let distanceWalkingRunning = LengthBiometric(healthKitIdentifier: .distanceWalkingRunning)
    
    /// A quantity sample type that measures the distance the user has moved using a wheelchair.
    ///
    /// These samples use length units (described in `HKUnit`) and measure cumulative values (described in `HKStatisticsQuery`).
    public static let distanceWheelchair = LengthBiometric(healthKitIdentifier: .distanceWheelchair)
    
    /// A quantity sample type that measures the distance covered by a single step while running.
    ///
    /// These samples use length units (described in `HKUnit`) and measure discrete values (described
    /// in `HKQuantityAggregationStyle`). During outdoor running workouts, the system automatically records
    /// running stride samples on Apple Watch SE and Series 6 and later.
    @available(iOS 16.0, *)
    public static let runningStrideLength = LengthBiometric(healthKitIdentifier: .runningStrideLength)
}

// MARK: - QueryExecutor + Length

public extension QueryExecutor {
    
    func fetch(
        _ biometric: LengthBiometric,
        in unit: LengthBiometric.UnitofMeasurement,
        options: QueryOptions
    ) async throws -> [Double] {
        let biometric = try CodableHealthBiometric(identifier: biometric.healthKitIdentifier)
        let samples = try await self.fetchSamples(for: biometric.sampleType, options: options)
        return samples.map { sample in
            return sample.quantity.doubleValue(for: unit.healthKitUnit)
        }
    }
}
