//
//  DataSourceTests.swift
//  RevolutTestTests
//
//  Created by Gregory Oberemkov on 20/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import XCTest
@testable import RevolutTest

class DataSourceTests: XCTestCase {
    
    // Test object
    var dataSource: DataSource?

    override func setUp() {
        dataSource = DataSource()
    }

    override func tearDown() {
        dataSource = nil 
    }
    
    /// Add element in datasource and test it 
    func testAddElement() {
        // Given
        let additionalElement = CurrenciesCellViewModel(image: #imageLiteral(resourceName: "img_revolut"),
                                                        abbreviation: "EUR",
                                                        currencyName: "Euro",
                                                        multiplier: 1.0,
                                                        numberOfCurrency: "1.0",
                                                        isFirstCell: true)
        
        // When
        dataSource?.addElement(additionalElement)
        
        // Then
        XCTAssertTrue((dataSource?.viewModel.contains(additionalElement))!)
        XCTAssertTrue(dataSource?.viewModelDictionary[additionalElement.abbreviation] == additionalElement)
    }
    
    /// Clear all elements in dataSource
    func testClearElements() {
        // Given
        let firstAdditionalElement = CurrenciesCellViewModel(image: #imageLiteral(resourceName: "img_revolut"),
                                                        abbreviation: "RUB",
                                                        currencyName: "Russian",
                                                        multiplier: 1.0,
                                                        numberOfCurrency: "1.0",
                                                        isFirstCell: true)
        
        let secondAdditionalElement = CurrenciesCellViewModel(image: #imageLiteral(resourceName: "img_revolut"),
                                                        abbreviation: "EUR",
                                                        currencyName: "Euro",
                                                        multiplier: 1.0,
                                                        numberOfCurrency: "1.0",
                                                        isFirstCell: true)
        
        // When
        dataSource?.addElement(firstAdditionalElement)
        dataSource?.addElement(secondAdditionalElement)
        dataSource?.clear()
        
        // Then
        XCTAssertTrue((dataSource?.viewModel.isEmpty)!)
        XCTAssertTrue((dataSource?.viewModelDictionary.isEmpty)!)
    }
    
}
