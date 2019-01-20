//
//  URLRequestConstructorMock.swift
//  RevolutTestTests
//
//  Created by Gregory Oberemkov on 20/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation
@testable import RevolutTest

final class URLRequestConstructorMock: RequestConstructor {
    
    var invokeCounter = 0
    var urlRequest: URLRequest = URLRequest(url: URL(string: "https://www.revolut.com")!)
    
    // MARK: - RequestConstructor
    
    func constructRequest(domainName: String, path: String, parameters: [String: String]?) -> URLRequest? {
        invokeCounter += 1
        return urlRequest 
    }
    
}
