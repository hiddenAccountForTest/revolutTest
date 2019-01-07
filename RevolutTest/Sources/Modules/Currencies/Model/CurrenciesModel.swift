//
//  CurrenciesModel.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 06/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation

struct CurrenciesModel: Decodable {
    
    let rates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case rates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rates = try container.decode([String: Double].self, forKey: .rates)
    }
}
