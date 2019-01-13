//
//  CurrenciesStateChangeDelegate.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 07/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation

protocol CurrenciesStateChangeDelegate: class {
    func changeMultiply(_ number: Float)
    func replaceMainCurrency(_ currency: String, withNumber number: Float)
}
