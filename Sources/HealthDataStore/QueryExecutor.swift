//
//  QueryExecutor.swift
//  Health
//
//  Created by Kelvin Kosbab on 4/16/22.
//

import Foundation
import HealthKit

// MARK: - QueryExecutor

public protocol QueryExecutor {
    
    /// After executing a query, the completion, update, and/or results handlers of that query will be invoked
    /// asynchronously on an arbitrary background queue as results become available.  Errors that prevent a
    /// query from executing will be delivered to one of the query's handlers.  Which handler the error will be
    /// delivered to is defined by the HKQuery subclass.
    ///
    /// Each HKQuery instance may only be executed once and calling this method with a currently executing query
    /// or one that was previously executed will result in an exception.
    ///
    /// If a query would retrieve objects with an HKObjectType property, then the application must request
    /// authorization to access objects of that type before executing the query.
    ///
    /// - Returns samples representing measurements taken over a period of time.
    func execute(
        for biometric: HealthBiometric,
        options: QueryOptions
    ) async throws -> [HKSample]
}

/// An object that provides configuration options for a Health Store query.
public struct QueryOptions {
    
    /// Defines the maximum number of results the receiver will return upon completion.
    public enum Limit {
        
        /// The query returns all samples that match the given sampleType and predicate.
        case noLimit
        
        /// The query returns the limit of samples specified from the `max` parameter.
        case limit(_ max: Int)
        
        /// The maximum number of results the receiver will return upon completion.
        var rawValue: Int {
            switch self {
            case .limit(let limit):
                return limit
            case .noLimit:
                return HKObjectQueryNoLimit
            }
        }
    }
    
    /// The start date limit of the query.
    ///
    /// If all health data is desired consider using `Date.distantPast`.
    let startDate: Date
    
    /// The end date limit of the query.
    let endDate: Date
    
    /// The maximum number of results the receiver will return upon completion.
    let limit: Limit
    
    /// An array of NSSortDescriptors.
    let sortDescriptors: [NSSortDescriptor]?
    
    public init(
        startDate: Date = .distantPast,
        endDate: Date = Date(),
        limit: Limit = .noLimit,
        sortDescriptors: [NSSortDescriptor]? = nil
    ) {
        self.startDate = startDate
        self.endDate = endDate
        self.limit = limit
        self.sortDescriptors = sortDescriptors
    }
}

// MARK: - HKHealthStore

extension HKHealthStore : QueryExecutor {
    
    public func execute(
        for biometric: HealthBiometric,
        options: QueryOptions
    ) async throws -> [HKSample] {
        return try await withCheckedThrowingContinuation { continuation in
            let predicate = HKQuery.predicateForSamples(withStart: options.startDate, end: options.endDate)
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate,
                                                  ascending: false)
            let query = HKSampleQuery(
                sampleType: biometric.sampleType,
                predicate: predicate,
                limit: options.limit.rawValue,
                sortDescriptors: [ sortDescriptor ]) { query, samples, error in
                    
                    guard let samples else {
                        if let error {
                            continuation.resume(throwing: error)
                        } else {
                            continuation.resume(returning: [])
                        }
                        return
                    }
                    
                    continuation.resume(returning: samples)
                }
            HKHealthStore().execute(query)
        }
    }
}
