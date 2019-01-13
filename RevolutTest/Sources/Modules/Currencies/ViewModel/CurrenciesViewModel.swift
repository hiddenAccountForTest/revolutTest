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
    var observerArray = [CurrencyCellObserver]()
    
    private(set) var cellViewModels: [CurrenciesCellViewModel] = []
    
    // MARK: - Private properties
    
    private var searchСurrency = "EUR"
    // todo rename
    private var number: Float = 1.0
    
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
        downloadNewCurrencies(abbreviation: searchСurrency)
    }
    
    // MARK: - Private methods
    
    private func createRequest(abbreviation: String) -> URLRequest? {
        
        let request = requestConstructor.constructRequest(domainName: "https://revolut.duckdns.org",
                                                          path: "/latest",
                                                          parameters: ["base" : abbreviation])
        
        return request
    }
    
    private func notify(_ number: Float) {
        cellViewModels.forEach { $0.delegate?.updateNumber($0.numberOfCurrency) }
    }
    
    private func downloadCurrencies(abbreviation: String) {
        
        guard let urlRequest = createRequest(abbreviation: searchСurrency) else {
            return
        }
        
        downloadService.downloadNews(request: urlRequest) { [weak self] result in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let dictionary):
            
            var coefficeintArray: [(String, Float)] = []
            
            for (key, value) in dictionary.rates {
                coefficeintArray.append((key, value))
            }
            
            coefficeintArray.sort {  $0.0 < $1.0 }
            
            for index in 1..<self.cellViewModels.count {
                self.cellViewModels[index].multiplier = coefficeintArray[index-1].1
            }
            
            self.changeMultiply(self.number)
                
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { self.downloadCurrencies(abbreviation: abbreviation) })
                
            case .error: break
            }
            
        }
        
    }
    
    private func downloadNewCurrencies(abbreviation: String) {
        
        guard let urlRequest = createRequest(abbreviation: abbreviation) else {
            return
        }
        
        downloadService.downloadNews(request: urlRequest) { [weak self] result in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let dictionary):
                
                for (key, value) in dictionary.rates {
                    
                    let country = self.countriesDataSource.fetchCountry(withAbbreviation: key)
                    
                    let cellModel = CurrenciesCellViewModel(image: country.image,
                                                            abbreviation: key,
                                                            currencyName: country.title,
                                                            multiplier: value,
                                                            numberOfCurrency: "\(value)",
                        isFirstCell: false,
                        delegate: nil)
                    
                    self.cellViewModels.append(cellModel)
                }
                
                self.cellViewModels.sort {  $0.abbreviation < $1.abbreviation }
                
                let country = self.countriesDataSource.fetchCountry(withAbbreviation: self.searchСurrency)
                
                let euroElement = CurrenciesCellViewModel(image: country.image,
                                                          abbreviation: self.searchСurrency,
                                                          currencyName: country.title,
                                                          multiplier: 1.0,
                                                          numberOfCurrency: String(1.0),
                                                          isFirstCell: true,
                                                          delegate: nil)
                
                self.cellViewModels.insert(euroElement, at: 0)
                
                self.downloadCurrencies(abbreviation: self.searchСurrency)
                
                DispatchQueue.main.async {
                    self.delegate?.updateTableView()
                }
            case .error:
                break
            }
        }
        
    }
    
}

// MARK: - CurrenciesStateChangeDelegate

extension CurrenciesViewModel: CurrenciesStateChangeDelegate {
    
    func replaceMainCurrency(_ currency: String, withNumber number: Float) {
        self.number = number
        cellViewModels = []
        downloadNewCurrencies(abbreviation: currency)
    }
    
    func changeMultiply(_ number: Float) {
        
        self.number = number
        cellViewModels[0].numberOfCurrency = "\(number)"
        cellViewModels[0].multiplier = number
        
        for index in 1..<cellViewModels.count {
            cellViewModels[index].numberOfCurrency = "\(number * Float(cellViewModels[index].multiplier))"
        }
        
        notify(number)
    }
    
}
