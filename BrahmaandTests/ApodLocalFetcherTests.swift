//
//  ApodLocalFetcherTests.swift
//  BrahmaandTests
//
//  Created by jaydeep on 31/03/21.
//

import XCTest
@testable import Brahmaand

class ApodLocalFetcherTests: XCTestCase {

    var localFetcher: ApodLocalStorage!

    override func setUp() {
        let db: SqliteDb = try! SqliteDb(databaseName: "brahmaand_test", createQueries: ApodLocalStorage.createQueries())
        self.localFetcher = ApodLocalStorage(db: db)
    }

    override func tearDown() {
        self.localFetcher.removeData()
    }

    func testApodLocalFetcher() {
        // Insert
        let apods = ApodTestData.testApods
        XCTAssertNoThrow(try localFetcher.insertApods(apods: apods), "Failed to insert apods")

        // Retrieve
        let fetchExpectation = XCTestExpectation(description: "Apods fetched!")
        localFetcher.fetchApods(startDate: apods.first!.date, endDate: apods.last!.date) { (result) in
            switch result {
            case .success(let fetchedApods):
                XCTAssertEqual(fetchedApods.count, apods.count)
                fetchExpectation.fulfill()
            default:
                XCTFail()
            }
        }
        wait(for: [fetchExpectation], timeout: 1)
    }
}
