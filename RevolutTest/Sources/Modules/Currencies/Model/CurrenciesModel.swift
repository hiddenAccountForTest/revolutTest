//
//  CurrenciesModel.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 06/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation

struct CurrenciesModel: Decodable, Equatable {

    let rates: [String: Float]

    enum CodingKeys: String, CodingKey {
        case rates
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rates = try container.decode([String: Float].self, forKey: .rates)
    }
    
    init(rates: [String: Float]) {
        self.rates = rates
    }
    
}
