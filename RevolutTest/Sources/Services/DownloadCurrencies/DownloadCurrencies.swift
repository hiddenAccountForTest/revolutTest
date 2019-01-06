//
//  DownloadCurrencies.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 06/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation

protocol DownloadCurrenciesService {
    func downloadNews(request: URLRequest, completionHandler: @escaping (Result<CurrenciesModel>) -> Void)
}
