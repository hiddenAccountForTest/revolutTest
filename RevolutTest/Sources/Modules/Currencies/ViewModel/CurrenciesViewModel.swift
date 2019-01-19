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
    
    // MARK: - Private properties
    
    // todo rename
    private var number: Float = 100.0
    
    private let downloadService: DownloadCurrenciesService
    private let requestConstructor: RequestConstructor
    private let countriesDataSource: CountriesDataSourceable
    private let viewModelDataSource: DataSourceInterface
    
    private var downloadOperation: GetNewContries?
    private let operationQueue: OperationQueue
    
    private var searchCurrency: String
    private var isExecutable = false
    
    // MARK: - Initilize
    
    init(downloadService: DownloadCurrenciesService,
         requestConstructor: RequestConstructor,
         viewModelDataSource: DataSourceInterface,
         countriesDataSource: CountriesDataSourceable,
         operationQueue: OperationQueue,
         searchCurrency: String) {
        
        self.searchCurrency = searchCurrency
        self.operationQueue = operationQueue
        self.downloadService = downloadService
        self.viewModelDataSource = viewModelDataSource
        self.requestConstructor = requestConstructor
        self.countriesDataSource = countriesDataSource
        self.downloadOperation = GetNewContries(downloadService: downloadService, urlRequestConstructor: requestConstructor, searchСurrency: searchCurrency)
        operationQueue.maxConcurrentOperationCount = 1
        downloadOperation?.output = self
        
    }
    
    // MARK: - Methods
    
    func getCellViewModels() -> [CurrenciesCellViewModel] {
        return viewModelDataSource.getViewModel()
    }
    
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
        viewModelDataSource.getViewModel().forEach { $0.delegate?.updateNumber($0.numberOfCurrency) }
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
    
    private func didUpdateCurrencies(currencies: CurrenciesModel, countryAbbreviation: String) {
        
        for (key, value) in currencies.rates {
            viewModelDataSource.getElement(withKey: key)?.multiplier = value
        }
        
        self.changeMultiply(self.number)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isExecutable = false
            self.updateCurrencies()
        }
        
    }
    
    private func didDownloadNewCurrencies(currencies: CurrenciesModel, countryAbbreviation: String) {
        
        let firstCountry = self.countriesDataSource.fetchCountry(withAbbreviation: countryAbbreviation)
    
        let firstElement = CurrenciesCellViewModel(image: firstCountry.image,
                                                  abbreviation: countryAbbreviation,
                                                  currencyName: firstCountry.title,
                                                  multiplier: 1.0,
                                                  numberOfCurrency: String(self.number),
                                                  isFirstCell: true,
                                                  delegate: nil)
        
        viewModelDataSource.addElement(firstElement)
        
        for (key, value) in currencies.rates {
            
            let country = self.countriesDataSource.fetchCountry(withAbbreviation: key)
            
            let cellModel = CurrenciesCellViewModel(image: country.image,
                                                    abbreviation: key,
                                                    currencyName: country.title,
                                                    multiplier: value,
                                                    numberOfCurrency: "\(self.number * value)",
                                                    isFirstCell: false,
                                                    delegate: nil)
            
            viewModelDataSource.addElement(cellModel)
        }
        
        viewModelDataSource.sortArray()
        
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
        viewModelDataSource.clear()
        
        downloadOperation = nil
        downloadOperation = GetNewContries(downloadService: downloadService, urlRequestConstructor: requestConstructor, searchСurrency: currency)
        downloadOperation?.output = self
        
        guard let downloadOperation = downloadOperation else { return }
            
        operationQueue.addOperation(downloadOperation)
    }
    
    func changeMultiply(_ number: Float) {
        
        self.number = number
        
        let viewModel = viewModelDataSource.getViewModel()
        
        viewModel.first?.numberOfCurrency = "\(number)"
        viewModel.first?.multiplier = number
        
        for index in 1..<viewModelDataSource.getViewModel().count {
            viewModel[index].numberOfCurrency = "\(number * Float(viewModel[index].multiplier))"
        }
        
        notify(number)
    }
    
}

// MARK: - GetNewContriesOuput

extension CurrenciesViewModel: GetNewContriesOuput {
    
    func didGetCurrencies(networkResult: CurrenciesModel?, forCountry countryAbbreviation: String) {

        downloadOperation = nil

        guard let result = networkResult else {
            return
        }
        
        if viewModelDataSource.getViewModel().count == 0 {
            isExecutable = false
            didDownloadNewCurrencies(currencies: result, countryAbbreviation: countryAbbreviation)
        } else {
            didUpdateCurrencies(currencies: result, countryAbbreviation: countryAbbreviation)
        }
        
        
    }
    
}
