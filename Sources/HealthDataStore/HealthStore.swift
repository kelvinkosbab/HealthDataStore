//
//  HealthStore.swift
//  Health
//
//  Created by Kelvin Kosbab on 4/16/22.
//

import Foundation
import HealthKit

// MARK: - HealthStoreQueryExecutor

public protocol HealthStoreQueryExecutor {

    func execute(_ query: HealthStore.Query)
}

// MARK: - HealthStore

public struct HealthStore : HealthStoreQueryExecutor {
    
    public struct Query {
        
        public enum Limit {
            case noLimit
            case limit(_ max: Int)
            
            var rawValue: Int {
                switch self {
                case .limit(let limit):
                    return limit
                case .noLimit:
                    return HKObjectQueryNoLimit
                }
            }
        }
        
        let startDate: Date
        let endDate: Date
        
        /// The maximum number of results the receiver will return upon completion.
        let limit: Limit
        
        /// An array of NSSortDescriptors.
        let sortDescriptors: [NSSortDescriptor]?
        
        init(
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
    
    public func execute(_ query: HealthStore.Query) {}
}
