//
//  QueryExecutorTests.swift
//
//  Created by Kelvin Kosbab on 10/1/22.
//

import XCTest
import HealthKit
@testable import HealthKitHelpers

// MARK: - Mocks

class MockQueryExecutor : QueryExecutor {
    
    var query: HKQuery?
    
    func execute(_ query: HKQuery) {
        self.query = query
    }
}

// MARK: - QueryExecutorTests

class QueryExecutorTests : XCTestCase {
    
    let queryOptionStartDate = Date()
    let queryOptionsEndDate = Date()
    
    var queryOptions: QueryOptions {
        return QueryOptions(
            startDate: self.queryOptionStartDate,
            endDate: self.queryOptionsEndDate
        )
    }
    
    func testQuerySampleTypeWithCompletionCallsHKExecute() {
        let excecutor = MockQueryExecutor()
    }
    
    func testQuerySampleTypeCallsHKExecute() async {
        
    }
    
    func testQueryIdentifierCallsHKExecute() async {
        do {
            let healthKitIdentifier: HKQuantityTypeIdentifier = .bodyTemperature
            let mock = MockQueryExecutor()
            _ = try await mock.query(
                identifier: healthKitIdentifier,
                unit: Length.meters,
                options: self.queryOptions)
            
            let test = try CodableHealthBiometric(identifier: healthKitIdentifier)
            XCTAssert(test.sampleType == mock.query?.sampleType)
        } catch {
            XCTFail("Test threw error: \(error)")
        }
    }
}
