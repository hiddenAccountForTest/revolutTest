//
//  DownloadCurrenciesServiceMock.swift
//  RevolutTestTests
//
//  Created by Gregory Oberemkov on 20/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation
@testable import RevolutTest

final class DownloadCurrenciesServiceMock: DownloadCurrenciesService {
    
    var invokeCounter = 0
    var urlRequest: URLRequest?
    var isFallible = false
    var successResult = CurrenciesModel(rates: ["EUR": 10.0])
    
    // MARK: - DownloadCurrenciesService
    
    func downloadCurrencies(request: URLRequest, completionHandler: @escaping (Result<CurrenciesModel>) -> Void) {
        invokeCounter += 1
        urlRequest = request
        
        if isFallible {
            completionHandler(.error(NetworkClientErrors.wrongData))
        } else {
            completionHandler(.success(successResult))
        }
    }
    
}
