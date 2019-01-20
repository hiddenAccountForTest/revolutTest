//
//  AppDelegate.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 05/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // swiftlint:disable line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let downloadService = DownloadCurrenciesImplementation(networkClient: NetworkClientImplementation.shared)
        let requestConstructor = RequestConstructorImplementation()
        let countriesDataSource = CountriesDataSource()

        let viewModel = CurrenciesViewModel(downloadService: downloadService,
                                            requestConstructor: requestConstructor,
                                            viewModelDataSource: DataSource(),
                                            countriesDataSource: countriesDataSource,
                                            operationQueue: OperationQueue(),
                                            searchCurrency: "EUR")
        
        let currenciesViewController = CurrenciesViewController(viewModel: viewModel)

        let navigationController = UINavigationController(rootViewController: currenciesViewController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

}
