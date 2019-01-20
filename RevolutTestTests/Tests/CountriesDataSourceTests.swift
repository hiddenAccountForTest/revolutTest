//
//  CountriesDataSourceTests.swift
//  RevolutTestTests
//
//  Created by Gregory Oberemkov on 20/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import XCTest
@testable import RevolutTest

class CountriesDataSourceTests: XCTestCase {

    // Test object
    var dataSource: CountriesDataSource?
    
    override func setUp() {
        dataSource = CountriesDataSource()
    }

    override func tearDown() {
        dataSource = nil
    }

    /// Fetch existing data from datasors
    func testFetchDataFromDataSource() {
        // Given
        let euroAbbreviation = "EUR"
        let zlotyAbbreviation = "PLN"
        let liraAbbreviation = "TRY"
        
        // When
        let euroModel = dataSource?.fetchCountry(withAbbreviation: euroAbbreviation)
        let zlotyModel = dataSource?.fetchCountry(withAbbreviation: zlotyAbbreviation)
        let liraModel = dataSource?.fetchCountry(withAbbreviation: liraAbbreviation)
        
        // Then
        XCTAssertEqual(euroModel?.title, "Euro")
        XCTAssertEqual(zlotyModel?.title, "Zloty")
        XCTAssertEqual(liraModel?.title, "Turkish Lira")
    }
    
    /// Fetch non existing data from datasors
    func testFetchNullFromDataSource() {
        // Given
        let nonExistingAbbreviation = "ABC"
        
        // When
        let model = dataSource?.fetchCountry(withAbbreviation: nonExistingAbbreviation)
        
        // Then
        XCTAssertEqual(model?.title, "")
    }

}
