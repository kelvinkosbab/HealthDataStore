//
//  Time.swift
//
//  Created by Kelvin Kosbab on 9/5/22.
//

import Foundation
import HealthKit

// MARK: - Time

/// Deinfes a unit of time.
public enum Time : String, Unit {
    
    /// Seconds is the SI unit of time.
    case seconds = "s"
    case minutes = "min"
    case hours = "hr"
    case days = "d"
    
    var healthKitUnit: HKUnit {
        switch self {
        case .seconds:
            return HKUnit.second()
        case .minutes:
            return HKUnit.minute()
        case .hours:
            return HKUnit.hour()
        case .days:
            return HKUnit.day()
        }
    }
}

// MARK: - TimeBiometric

public struct TimeBiometric : Biometric {
    
    public static let Units = Time.self
    
    public let healthKitIdentifier: HKQuantityTypeIdentifier
    
    /// A quantity sample type that measures the amount of time the user spent exercising.
    ///
    /// This quantity type measures every full minute of movement that equals or exceeds the intensity of a brisk walk.
    ///
    /// Apple watch automatically records exercise time. By default, the watch uses the accelerometer to estimate the
    /// intensity of the user’s movement. However, during workout sessions, the watch uses additional sensors, like the
    /// heart rate sensor and GPS, to generate estimates.
    ///
    /// `HKWorkoutSession` sessions also contribute to the exercise time. For more information, see Fill the Activity
    /// Rings.
    ///
    /// These samples use time units (described in `HKUnit`) and measure cumulative values (described in `HKStatisticsQuery`).
    public static let appleExerciseTime = Self(healthKitIdentifier: .appleExerciseTime)
    
    /// A quantity sample type that measures the amount of time the user has spent standing.
    ///
    /// These samples use time units (described in `HKUnit`) and measure cumulative values (described in `HKStatisticsQuery`).
    public static let appleStandTime = Self(healthKitIdentifier: .appleStandTime)
}

// MARK: - QueryExecutor + Time

public extension QueryExecutor {
    
    func fetch(
        _ biometric: TimeBiometric,
        in unit: TimeBiometric.UnitofMeasurement,
        options: QueryOptions
    ) async throws -> [QueryResult] {
        return try await self.fetch(
            healthKitIdentifier: biometric.healthKitIdentifier,
            unit: unit,
            options: options
        )
    }
}

// MARK: - HealthKitAuthorizor + Time

public extension HealthKitAuthorizor {
    
    func getRequestStatusForAuthorization(
        toShare typesToShare: Set<TimeBiometric>,
        read typesToRead: Set<TimeBiometric>
    ) async throws -> HKAuthorizationRequestStatus {
        return try await self.internalGetRequestStatusForAuthorization(toShare: typesToShare, read: typesToRead)
    }
    
    func requestAuthorization(
        toShare typesToShare: Set<TimeBiometric>,
        read typesToRead: Set<TimeBiometric>
    ) async throws {
        return try await self.internalRequestAuthorization(toShare: typesToShare, read: typesToRead)
    }
}
