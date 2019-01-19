//
//  CurrenciesCellViewModel.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 06/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation
import UIKit

final class CurrenciesCellViewModel {
    
    // MARK: - Properties
    
    let image: UIImage
    let abbreviation: String
    let currencyName: String
    var multiplier: Float
    var numberOfCurrency: String
    var isFirstCell: Bool
    var delegate: CurrencyCellObserver? = nil
    
    // MARK: - Initilize
    
    init(image: UIImage,
         abbreviation: String,
         currencyName: String,
         multiplier: Float,
         numberOfCurrency: String,
         isFirstCell: Bool,
         delegate: CurrencyCellObserver? = nil) {
        self.image = image
        self.abbreviation = abbreviation
        self.currencyName = currencyName
        self.multiplier = multiplier
        self.numberOfCurrency = numberOfCurrency
        self.isFirstCell = isFirstCell
        self.delegate = delegate
    }
    
}

// MARK: - Comparable

extension CurrenciesCellViewModel: Comparable {
    
    static func < (lhs: CurrenciesCellViewModel, rhs: CurrenciesCellViewModel) -> Bool {
        return lhs.abbreviation < rhs.abbreviation
    }
    
    static func == (lhs: CurrenciesCellViewModel, rhs: CurrenciesCellViewModel) -> Bool {
        return lhs.abbreviation == rhs.abbreviation
    }
    
}
