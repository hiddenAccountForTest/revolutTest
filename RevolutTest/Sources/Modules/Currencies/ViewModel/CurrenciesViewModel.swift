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
    
    private(set) var cellViewModels: [CurrenciesCellViewModel] = []
    
    // MARK: - Private properties
    
    // todo rename
    private var number: Float = 100.0
    
    private let downloadService: DownloadCurrenciesService
    private let requestConstructor: RequestConstructor
    private let countriesDataSource: CountriesDataSourceable
    
    private var downloadOperation: GetNewContries?
    private let operationQueue: OperationQueue
    
    private var searchCurrency: String
    private var isExecutable = false
    
    // MARK: - Initilize
    
    init(downloadService: DownloadCurrenciesService, requestConstructor: RequestConstructor, countriesDataSource: CountriesDataSourceable, operationQueue: OperationQueue, searchCurrency: String) {
        self.searchCurrency = searchCurrency
        self.operationQueue = operationQueue
        self.downloadService = downloadService
        self.requestConstructor = requestConstructor
        self.countriesDataSource = countriesDataSource
        self.downloadOperation = GetNewContries(downloadService: downloadService, urlRequestConstructor: requestConstructor, searchСurrency: searchCurrency)
        operationQueue.maxConcurrentOperationCount = 1
        downloadOperation?.output = self
    }
    
    // MARK: - Public methods
    
    func startDownloadCurrenciesWithEuro() {
        guard let downloadOperation = downloadOperation else {
            return
        }
        operationQueue.addOperation(downloadOperation)
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

    private func updateCurrencies() {
        if !isExecutable {
        isExecutable = true
        operationQueue.cancelAllOperations()
        downloadOperation = nil
        downloadOperation = GetNewContries(downloadService: downloadService, urlRequestConstructor: requestConstructor, searchСurrency: searchCurrency)
        downloadOperation?.output = self
            
        guard let downloadOperation = downloadOperation else {
            return
        }
            
        operationQueue.addOperation(downloadOperation)
        }
        
    }
    
    private func didUpdateCurrencies(currencies: CurrenciesModel?, countryAbbreviation: String) {
        
        var coefficeintArray: [(String, Float)] = []
        
        guard let resultDictionary = currencies?.rates else {
            return
        }
        
        for (key, value) in resultDictionary {
            coefficeintArray.append((key, value))
        }
        
        coefficeintArray.sort {  $0.0 < $1.0 }
        
        guard self.cellViewModels.count > 0 else {
            return
        }
        
        for index in 1..<self.cellViewModels.count {
            self.cellViewModels[index].multiplier = coefficeintArray[index-1].1
        }
        
        self.changeMultiply(self.number)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isExecutable = false
            self.updateCurrencies()
        }
        
    }
    
    private func didDownloadNewCurrencies(currencies: CurrenciesModel?, countryAbbreviation: String) {
        
        guard let resultDictionary = currencies?.rates else {
            return
        }
        
        for (key, value) in resultDictionary {
            
            let country = self.countriesDataSource.fetchCountry(withAbbreviation: key)
            
            let cellModel = CurrenciesCellViewModel(image: country.image,
                                                    abbreviation: key,
                                                    currencyName: country.title,
                                                    multiplier: value,
                                                    numberOfCurrency: "\(self.number * value)",
                isFirstCell: false,
                delegate: nil)
            
            self.cellViewModels.append(cellModel)
        }
        
        self.cellViewModels.sort {  $0.abbreviation < $1.abbreviation }
        
        let country = self.countriesDataSource.fetchCountry(withAbbreviation: countryAbbreviation)
        
        let euroElement = CurrenciesCellViewModel(image: country.image,
                                                  abbreviation: countryAbbreviation,
                                                  currencyName: country.title,
                                                  multiplier: 1.0,
                                                  numberOfCurrency: String(self.number),
                                                  isFirstCell: true,
                                                  delegate: nil)
        
        self.cellViewModels.insert(euroElement, at: 0)
        
        DispatchQueue.main.async {
            self.delegate?.updateTableView()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateCurrencies()
        }
        
    }
    
}

// MARK: - CurrenciesStateChangeDelegate

extension CurrenciesViewModel: CurrenciesStateChangeDelegate {

    func replaceMainCurrency(_ currency: String, withNumber number: Float) {
        self.searchCurrency = currency
        self.number = number
        
        operationQueue.cancelAllOperations()
        cellViewModels = []
        
        downloadOperation = nil
        downloadOperation = GetNewContries(downloadService: downloadService, urlRequestConstructor: requestConstructor, searchСurrency: currency)
        downloadOperation?.output = self
        
        guard let downloadOperation = downloadOperation else { return }
            
        operationQueue.addOperation(downloadOperation)
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

// MARK: - GetNewContriesOuput

extension CurrenciesViewModel: GetNewContriesOuput {
    
    func didGetCurrencies(networkResult: CurrenciesModel?, forCountry countryAbbreviation: String) {

        downloadOperation = nil
        
        if cellViewModels.count == 0 {
            isExecutable = false
            didDownloadNewCurrencies(currencies: networkResult, countryAbbreviation: countryAbbreviation)
        } else {
            didUpdateCurrencies(currencies: networkResult, countryAbbreviation: countryAbbreviation)
        }
        
        
    }
    
}
