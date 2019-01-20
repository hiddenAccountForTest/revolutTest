//
//  NetworkOperations.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 17/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation

protocol GetNewContriesOuput: class {
    func didGetCurrencies(networkResult: CurrenciesModel?, forCountry countryAbbreviation: String)
}

final class GetNewContries: Operation {
    
    weak var output: GetNewContriesOuput?
    
    // MARK: - Private properties
    
    private let searchСurrency: String
    private let downloadService: DownloadCurrenciesService
    private let urlRequestConstructor: RequestConstructor
    
    // MARK: - Initilize
    
    init(downloadService: DownloadCurrenciesService, urlRequestConstructor: RequestConstructor, searchСurrency: String) {
        self.searchСurrency = searchСurrency
        self.downloadService = downloadService
        self.urlRequestConstructor = urlRequestConstructor
    }
    
    override func main() {
        
        if isCancelled {
            return
        }
        
        guard let urlRequest = createRequest(abbreviation: searchСurrency) else {
            return
        }
        
        if isCancelled {
            return
        }
        
        downloadService.downloadCurrencies(request: urlRequest) { [weak self] result in
            
            guard let `self` = self else {
                return
            }
            
            if self.isCancelled {
                return
            }
            
            switch result {
            case .success(let dictionary):
                self.output?.didGetCurrencies(networkResult: dictionary, forCountry: self.searchСurrency)
            case .error:
                break
            }
            
        }
    }
    
    private func createRequest(abbreviation: String) -> URLRequest? {
        
        let request = urlRequestConstructor.constructRequest(domainName: "https://revolut.duckdns.org",
                                                          path: "/latest",
                                                          parameters: ["base" : abbreviation])
        
        return request
    }
    
    
}
