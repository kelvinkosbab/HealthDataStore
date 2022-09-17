//
//  QueryExecutor.swift
//  Health
//
//  Created by Kelvin Kosbab on 4/16/22.
//

import Foundation
import HealthKit

// MARK: - QueryExecutor

/// Defines objects that can execute HealthKit queries.
@available(macOS 13.0, *)
public protocol QueryExecutor {
    
    /// After executing a query, the completion, update, and/or results handlers of that query will be invoked
    /// asynchronously on an arbitrary background queue as results become available.  Errors that prevent a
    /// query from executing will be delivered to one of the query's handlers.  Which handler the error will be
    /// delivered to is defined by the `HKQuery` subclass.
    ///
    /// Each HKQuery instance may only be executed once and calling this method with a currently executing query
    /// or one that was previously executed will result in an exception.
    ///
    /// If a query would retrieve objects with an `HKObjectType` property, then the application must request
    /// authorization to access objects of that type before executing the query.
    ///
    /// - Returns samples representing measurements taken over a period of time.
    func fetchSamples(
        for sampleType: HKSampleType,
        options: QueryOptions
    ) async throws -> [HKQuantitySample]
}

// MARK: - QueryError

/// Defines errors thrown when executing a health query.
public enum QueryError : Error {
    
    /// After a query it is expected to be able to cast to a `HKQuantitySample` type. This error is thrown when the returned
    /// samples do not conform to `HKQuantitySample`.
    case unsupportedSampleType(samples: [HKSample])
}

// MARK: - HKHealthStore

@available(macOS 13.0, *)
extension HKHealthStore : QueryExecutor {
    
    public func fetchSamples(
        for sampleType: HKSampleType,
        options: QueryOptions
    ) async throws -> [HKQuantitySample] {
        return try await withCheckedThrowingContinuation { continuation in
            let predicate = HKQuery.predicateForSamples(
                withStart: options.startDate,
                end: options.endDate
            )
            
            let sortDescriptor = NSSortDescriptor(
                key: HKSampleSortIdentifierStartDate,
                ascending: false
            )
            
            let query = HKSampleQuery(
                sampleType: sampleType,
                predicate: predicate,
                limit: options.limit.rawValue,
                sortDescriptors: options.sortDescriptors ?? [ sortDescriptor ]
            ) { _, samples, error in
                
                guard let samples else {
                    if let error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(returning: [])
                    }
                    return
                }
                
                guard let quantitySamples = samples as? [HKQuantitySample] else {
                    continuation.resume(throwing: QueryError.unsupportedSampleType(samples: samples))
                    return
                }
                
                continuation.resume(returning: quantitySamples)
            }
            
            HKHealthStore().execute(query)
        }
    }
}
