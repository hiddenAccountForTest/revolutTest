//
//  DataSourceMock.swift
//  RevolutTestTests
//
//  Created by Gregory Oberemkov on 20/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation
@testable import RevolutTest

final class DataSourceMock: DataSourceInterface {
    
    var addElementCounter = 0
    var clearCounter = 0
    
    let array: [CurrenciesCellViewModel] = [
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

    // MARK: - DataSourceInterface
    
    func addElement(_ element: CurrenciesCellViewModel) {
        addElementCounter += 1
    }
    
    func getElement(withKey key: String) -> CurrenciesCellViewModel? {
        return nil
    }
    
    func getViewModel() -> [CurrenciesCellViewModel] {
        return array
    }
    
    func clear() {
        clearCounter += 1
    }
    
    func sortArray() {
        
    }
    
}
