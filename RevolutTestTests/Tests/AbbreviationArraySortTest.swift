//
//  AbbreviationArraySortTest.swift
//  RevolutTestTests
//
//  Created by Gregory Oberemkov on 20/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import XCTest
@testable import RevolutTest

class AbbreviationArraySortTest: XCTestCase {
    
    // Stub
    var array: [CurrenciesCellViewModel] = [
        CurrenciesCellViewModel(image: #imageLiteral(resourceName: "img_revolut"), abbreviation: "EUR", currencyName: "",
                                multiplier: 1.0, numberOfCurrency: "", isFirstCell: true),
        CurrenciesCellViewModel(image: #imageLiteral(resourceName: "img_revolut"), abbreviation: "AUD", currencyName: "",
                                multiplier: 1.0, numberOfCurrency: "", isFirstCell: true),
        CurrenciesCellViewModel(image: #imageLiteral(resourceName: "img_revolut"), abbreviation: "BGN", currencyName: "",
                                multiplier: 1.0, numberOfCurrency: "", isFirstCell: true),
        CurrenciesCellViewModel(image: #imageLiteral(resourceName: "img_revolut"), abbreviation: "BRL", currencyName: "",
                                multiplier: 1.0, numberOfCurrency: "", isFirstCell: true),
        CurrenciesCellViewModel(image: #imageLiteral(resourceName: "img_revolut"), abbreviation: "CAD", currencyName: "",
                                multiplier: 1.0, numberOfCurrency: "", isFirstCell: true),
        CurrenciesCellViewModel(image: #imageLiteral(resourceName: "img_revolut"), abbreviation: "CHF", currencyName: "",
                                multiplier: 1.0, numberOfCurrency: "", isFirstCell: true),
        CurrenciesCellViewModel(image: #imageLiteral(resourceName: "img_revolut"), abbreviation: "CNY", currencyName: "",
                                multiplier: 1.0, numberOfCurrency: "", isFirstCell: true),
        CurrenciesCellViewModel(image: #imageLiteral(resourceName: "img_revolut"), abbreviation: "CZK", currencyName: "",
                                multiplier: 1.0, numberOfCurrency: "", isFirstCell: true),
        CurrenciesCellViewModel(image: #imageLiteral(resourceName: "img_revolut"), abbreviation: "DKK", currencyName: "",
                                multiplier: 1.0, numberOfCurrency: "", isFirstCell: true),
        CurrenciesCellViewModel(image: #imageLiteral(resourceName: "img_revolut"), abbreviation: "HKD", currencyName: "",
                                multiplier: 1.0, numberOfCurrency: "", isFirstCell: true)
    ]
    
    /// Sort currenciesCellViewModel array since first element
    func testSortAbbreviationArray() {
        // When
        array.insertionSortFromIndexFirst()
        
        // Then
        for index in 1..<array.count - 1 {
            XCTAssertTrue(array[index].abbreviation < array[index + 1].abbreviation)
        }
    }
    
}
