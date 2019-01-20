//
//  DownloadCurrenciesImplementation.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 06/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation

final class DownloadCurrenciesImplementation {

    // MARK: - Properties

    private let networkClient: NetworkClient

    // MARK: - Initilize

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

}

// MARK: - DownloadCurrencies

extension DownloadCurrenciesImplementation: DownloadCurrenciesService {

    func downloadCurrencies(request: URLRequest, completionHandler: @escaping (Result<CurrenciesModel>) -> Void) {
        networkClient.fetchRequest(request: request, completion: completionHandler)
    }

}
