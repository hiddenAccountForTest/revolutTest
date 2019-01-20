//
//  ViewModelTests.swift
//  RevolutTestTests
//
//  Created by Gregory Oberemkov on 20/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import XCTest
@testable import RevolutTest

class ViewModelTests: XCTestCase {
    
    // Test object
    var viewModel: CurrenciesViewModel?
    
    // Mocks
    
    let downloadServiceMock = DownloadCurrenciesServiceMock()
    let requestConstructorMock = URLRequestConstructorMock()
    let dataSourceMock = DataSourceMock()
    let countriesDataSource = CountriesDataSource()
    let operationQueueMock = OperationQueueMock()
    
    // Stub
    var searchCurrency = "EUR"

    override func setUp() {
        viewModel = CurrenciesViewModel(downloadService: downloadServiceMock,
                                        requestConstructor: requestConstructorMock,
                                        viewModelDataSource: dataSourceMock,
                                        countriesDataSource: countriesDataSource,
                                        operationQueue: operationQueueMock,
                                        searchCurrency: searchCurrency)
    }

    override func tearDown() {
        viewModel = nil
    }
    
    // Test getCellViewModels should return viewModelDataSource models
    func testGetCellViewModels() {
        // Given
        let viewModels = dataSourceMock.array
        
        // When
        let getResult = viewModel!.getCellViewModels()
        
        // Then
        XCTAssertEqual(viewModels, getResult)
    }
    
    // Test startDownloadCurrencies create downloadOperation
    func testAfterStartDownloadCurrenciesOpertaionNotNil() {
        // When
        viewModel?.startDownloadCurrencies()
        
        // Then
        XCTAssertNotNil(viewModel?.downloadOperation)
    }
    
    // Test startDownloadCurrencies add downloadOperation in OperationQueue
    func testAfterStartDownloadCurrenciesOpertaionQueueAddOperation() {
        // Given
        let counter = 1
        
        // When
        viewModel?.startDownloadCurrencies()
        
        // Then
        XCTAssertEqual(operationQueueMock.addOperationCounter, counter)
    }
    
    // Test clear dataSource and cancel all opertaion after replaceMainCurrency
    func testReplaceMainCurrencyCancelOperationsAndCleanDataSource() {
        // Given
        let cleanDataSourceCounter = 1
        let addOperationCounter = 1
        let currencyStub = "EUR"
        let numberStub: Float  = 10.0
        
        // When
        viewModel?.replaceMainCurrency(currencyStub, withNumber: numberStub)
        
        // Then
        XCTAssertFalse(operationQueueMock.isCancel)
        XCTAssertEqual(dataSourceMock.clearCounter, cleanDataSourceCounter)
        XCTAssertEqual(operationQueueMock.addOperationCounter, addOperationCounter)
    }
    
    // Test changeMultiply change viewModel
    func testChangeMultiplyChangeViewModelToo() {
        // Given
        var viewModelDataSource: [String] = []
        dataSourceMock.getViewModel().forEach {
            viewModelDataSource.append($0.numberOfCurrency)
        }
        let multiplyStub: Float = 10.0
        
        // When
        viewModel?.changeMultiply(multiplyStub)
        var resultNumberOfCurrency: [String] = []
        dataSourceMock.getViewModel().forEach {
            resultNumberOfCurrency.append($0.numberOfCurrency)
        }
        
        // Then
        XCTAssertNotEqual(viewModelDataSource, resultNumberOfCurrency)
    }
    
    // Test didGetCurrencies delete operation
    func testAfterDidGetCurrenciesDeleteOperation() {
        // When
        viewModel?.didGetCurrencies(networkResult: nil, forCountry: "EUR")
        
        // Then
        XCTAssertNil(viewModel?.downloadOperation)
    }
    
    // Test downloadOperationWasFailed invoke delegate method
    func testDownloadOperationWasFailed() {
        // Given
        let delegate = CurrenciesViewModelDelegateMock()
        viewModel?.delegate = delegate
        
        // When
        viewModel?.downloadOperationWasFailed()
        
        // Then
        XCTAssertTrue(delegate.showNetworkAlert)
    }

    // Test didGetCurrencies stop activity indicator
    func testDidGetCurrenciesCommunicateWithDelegate() {
        // Given
        let delegate = CurrenciesViewModelDelegateMock()
        viewModel?.delegate = delegate
        
        // When
        viewModel?.didGetCurrencies(networkResult: nil, forCountry: "EUR")
        
        // Then
        XCTAssertFalse(delegate.activityIndicatorIsAnimating)
    }

    // Test replaceMainCurrency start activity indicator
    func testReplaceMainCurrencyCommunicateWithDelegate() {
        // Given
        let delegate = CurrenciesViewModelDelegateMock()
        viewModel?.delegate = delegate
        
        // When
        viewModel?.replaceMainCurrency("EUR", withNumber: 10.0)
        
        // Then
        XCTAssertTrue(delegate.activityIndicatorIsAnimating)
    }
}
