import XCTest
@testable import CloudHealthDataStore

final class CloudHealthDataStoreTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(HealthDataStore().text, "Hello, World!")
    }
}
