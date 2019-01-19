//
//  DataSource.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 19/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation

protocol DataSourceInterface {
    func addElement(_ element: CurrenciesCellViewModel)
    func getElement(withKey key: String) -> CurrenciesCellViewModel?
    func getViewModel() -> [CurrenciesCellViewModel]
    func clear()
    func sortArray()
}

final class DataSource {
    
    private var viewModel: [CurrenciesCellViewModel] = []
    private var viewModelDictionary: [String : CurrenciesCellViewModel] = [:]
    
}

// MARK: - DataSourceInterface

extension DataSource: DataSourceInterface {
    
    func addElement(_ element: CurrenciesCellViewModel) {
        viewModel.append(element)
        viewModelDictionary[element.abbreviation] = element
    }
    
    func getElement(withKey key: String) -> CurrenciesCellViewModel? {
        return viewModelDictionary[key]
    }
    
    func getViewModel() -> [CurrenciesCellViewModel] {
        return viewModel
    }
    
    func clear() {
        viewModel = []
        viewModelDictionary = [:]
    }
    
    func sortArray() {
        viewModel.insertionSortFromIndexFirst()
    }
    
}
