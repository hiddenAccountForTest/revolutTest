//
//  GetNewContriesTests.swift
//  RevolutTestTests
//
//  Created by Gregory Oberemkov on 20/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import XCTest
@testable import RevolutTest

class GetNewContriesTests: XCTestCase {

    // Test object
    var networkOpertaion: GetNewContries?
    
    // Mocks
    let downloadService = DownloadCurrenciesServiceMock()
    let requestConstructor = URLRequestConstructorMock()
    
    // Stub
    let searchСurrency = "EUR"
    
    override func setUp() {
        networkOpertaion = GetNewContries(downloadService: downloadService,
                                          urlRequestConstructor: requestConstructor,
                                          searchСurrency: searchСurrency)
    }

    override func tearDown() {
        networkOpertaion = nil
    }
    
    /// Request constructor called once
    func testRequestConstructorCalledCounter() {
        // Given
        let invokeCounter = 1
        let operationQueue = OperationQueue()
        
        // When
        operationQueue.addOperation(networkOpertaion!)
        
        // Then
        networkOpertaion?.completionBlock = {
            XCTAssertEqual(self.requestConstructor.invokeCounter, invokeCounter)
        }
    }
    
    /// The download service uses the request that the requester has generated
    func testDownloadServiceUseRequest() {
        // Given
        let requestConstructorURL = requestConstructor.urlRequest
        
        // When
        OperationQueue().addOperation(networkOpertaion!)
        
        // Then
        networkOpertaion?.completionBlock = {
            XCTAssertEqual(requestConstructorURL, self.downloadService.urlRequest)
        }
    }
    
    /// DownloadService constructor called once
    func testDownloadServiceCalledCounter() {
        // Given
        let invokeCounter = 1
        
        // When
        OperationQueue().addOperation(networkOpertaion!)
        
        // Then
        networkOpertaion?.completionBlock = {
            XCTAssertEqual(self.downloadService.invokeCounter, invokeCounter)
        }
    }
    
    /// Fallible delegate called once
    func testDownloadServiceFailAndInvokeFalliableDelegate() {
        // Given
        let output = GetNewContriesOuputMock()
        let invokeCounter = 1
        downloadService.isFallible = true
        networkOpertaion?.output = output
            
        // When
        OperationQueue().addOperation(networkOpertaion!)
        
        // Then
        networkOpertaion?.completionBlock = {
            XCTAssertEqual(invokeCounter, output.failCounter)
        }
    }
    
    /// Succesfull delegate called once
    func testDownloadServiceSuccessAndInvokeSuccessfulDelegate() {
        // Given
        let output = GetNewContriesOuputMock()
        let invokeCounter = 1
        downloadService.isFallible = false
        networkOpertaion?.output = output
        
        // When
        OperationQueue().addOperation(networkOpertaion!)
        
        // Then
        networkOpertaion?.completionBlock = {
            XCTAssertEqual(invokeCounter, output.successCounter)
        }
    }
    
    /// Successfull delegate get data from
    func testDownloadServiceSuccessAndInvokeDelegateWithProperties() {
        // Given
        let output = GetNewContriesOuputMock()
        downloadService.isFallible = false
        networkOpertaion?.output = output
        
        // When
        OperationQueue().addOperation(networkOpertaion!)
        
        // Then
        networkOpertaion?.completionBlock = {
            XCTAssertEqual(self.downloadService.successResult, output.result)
        }
    }

}
