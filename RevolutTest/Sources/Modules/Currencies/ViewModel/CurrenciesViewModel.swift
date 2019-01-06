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
    private(set) var cellViewModels: [CurrenicesCellViewModel] = []
    
    // MARK: - Private properties
    
    private let downloadService: DownloadCurrenciesService
    private let requestConstructor: RequestConstructor
    
    // MARK: - Initilize
    
    init(downloadService: DownloadCurrenciesService, requestConstructor: RequestConstructor) {
        self.downloadService = downloadService
        self.requestConstructor = requestConstructor
    }
    
    // MARK: - Public properties
    
    func downloadCurrencies() {
        let request = requestConstructor.constructRequest(domainName: "https://revolut.duckdns.org",
                                                          path: "/latest",
                                                          parameters: ["base" : "EUR"])
        
        guard let urlRequest = request else {
            return
        }
        
        // todo weak self
        downloadService.downloadNews(request: urlRequest) { result in
            switch result {
            case .success(let dictionary):
                
                for (key, value) in dictionary.rates {
                    let cellModel = CurrenicesCellViewModel(image: #imageLiteral(resourceName: "Image"), abbreviation: key, currencyName: key, numberOfCurrency: String(value))
                    self.cellViewModels.append(cellModel)
                }
                
                DispatchQueue.main.async {
                    self.delegate?.updateTableView()
                }
            case .error:
                break
            }
        }
    }
    
    // MARK: - Private properties
    
    
}
