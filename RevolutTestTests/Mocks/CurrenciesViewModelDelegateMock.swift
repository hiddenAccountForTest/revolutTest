//
//  CurrenciesViewModelDelegateMock.swift
//  RevolutTestTests
//
//  Created by Gregory Oberemkov on 21/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation
@testable import RevolutTest

final class CurrenciesViewModelDelegateMock: CurrenciesViewModelDelegate {
    
    var activityIndicatorIsAnimating: Bool = false
    var showNetworkAlert: Bool = false
    
    func showNetworkConnectionAlert() {
        showNetworkAlert = true
    }
    
    func updateTableView() {
    }
    
    func startActivityIndicator() {
        activityIndicatorIsAnimating = true
    }
    
    func stopActivityIndicator() {
        activityIndicatorIsAnimating = false
    }
    
}
