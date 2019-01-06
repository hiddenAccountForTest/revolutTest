//
//  RequestConstructor.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 06/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation

protocol RequestConstructor {
    func constructRequest(domainName: String, path: String, parameters: [String : String]? ) -> URLRequest?
}
