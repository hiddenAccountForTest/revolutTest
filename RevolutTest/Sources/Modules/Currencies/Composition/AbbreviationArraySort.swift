//
//  AbbreviationArraySort.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 19/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation

extension Array where Element: CurrenciesCellViewModel {

    mutating func insertionSortFromIndexFirst() {
        for index in 2..<self.count {
            var changableIndex = index
            while changableIndex > 1 && self[changableIndex] < self[changableIndex - 1] {
                self.swapAt(changableIndex - 1, changableIndex)
                changableIndex -= 1
            }
        }
    }

}
