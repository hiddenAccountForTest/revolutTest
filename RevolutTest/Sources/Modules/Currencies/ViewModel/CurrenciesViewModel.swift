//
//  CurrenciesViewModel.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 06/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation

final class CurrenciesViewModel {
    
    // MARK: - Properties
    
    weak var delegate: CurrenciesViewModelDelegate?
    
    // todo check arc
    var observerArray = [CurrencyCellObserver]() {
        didSet {
            print(observerArray)
        }
    }
    
    private(set) var cellViewModels: [CurrenciesCellViewModel] = []
    
    // MARK: - Private properties
    
    private var searchСurrency = "EUR"
    
    private let downloadService: DownloadCurrenciesService
    private let requestConstructor: RequestConstructor
    private let countriesDataSource: CountriesDataSourceable
    
    // MARK: - Initilize
    
    init(downloadService: DownloadCurrenciesService, requestConstructor: RequestConstructor, countriesDataSource: CountriesDataSourceable) {
        self.downloadService = downloadService
        self.requestConstructor = requestConstructor
        self.countriesDataSource = countriesDataSource
    }
    
    // MARK: - Public methods
    
    func startDownloadCurrenciesWithEuro() {
        
        let request = requestConstructor.constructRequest(domainName: "https://revolut.duckdns.org",
                                                          path: "/latest",
                                                          parameters: ["base" : "EUR"])
        
        guard let urlRequest = request else {
            return
        }
        
        downloadService.downloadNews(request: urlRequest) { [weak self] result in
            switch result {
            case .success(let dictionary):
                
                guard let `self` = self else { return }
                
                for (key, value) in dictionary.rates {
                    let country = self.countriesDataSource.fetchCountry(withAbbreviation: key)
                    let cellModel = CurrenciesCellViewModel(image: country.image, abbreviation: key, currencyName: country.title, numberOfCurrency: value)
                    self.cellViewModels.append(cellModel)
                }
                
                self.cellViewModels.sort {  $0.abbreviation < $1.abbreviation }
                
                let country = self.countriesDataSource.fetchCountry(withAbbreviation: self.searchСurrency)
                
                let euroElement = CurrenciesCellViewModel(image: country.image,
                                                          abbreviation: self.searchСurrency,
                                                          currencyName: country.title,
                                                          numberOfCurrency: 1)
                
                self.cellViewModels.insert(euroElement, at: 0)
                
                DispatchQueue.main.async {
                    self.delegate?.updateTableView()
                }
            case .error:
                break
            }
        }
    }
    
    // MARK: - Private methods
    
    private func notify() {
        for (index, observer) in observerArray.enumerated() {
            print(observerArray.count)
            observer.updateNumber(cellViewModels[index].numberOfCurrency)
        }
    }
    
}

// MARK: - CurrenciesStateChangeDelegate

extension CurrenciesViewModel: CurrenciesStateChangeDelegate {
    
    func changeMultiply(_ number: Double) {
        
        for index in 1..<cellViewModels.count {
            cellViewModels[index].numberOfCurrency = number * cellViewModels[index].numberOfCurrency
        }
        
        notify()
    }
    
}
