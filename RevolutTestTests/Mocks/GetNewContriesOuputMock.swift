//
//  GetNewContriesOuputMock.swift
//  RevolutTestTests
//
//  Created by Gregory Oberemkov on 20/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation
@testable import RevolutTest

final class GetNewContriesOuputMock: GetNewContriesOuput {

    var result: CurrenciesModel?
    var successCounter = 0
    var failCounter = 0
    
    // MARK: - GetNewContriesOuput
    
    func didGetCurrencies(networkResult: CurrenciesModel?, forCountry countryAbbreviation: String) {
        successCounter += 1
        result = networkResult
    }
    
    func downloadOperationWasFailed() {
        failCounter += 1
    }
    
}
