//
//  RequestConstructorImplementation.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 06/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation

final class RequestConstructorImplementation: RequestConstructor {
    
    func constructRequest(domainName: String, path: String, parameters: [String : String]? ) -> URLRequest? {
        
        guard var apiURL = URLComponents(string: domainName + path) else {
            return nil
        }
        
        apiURL.queryItems = parameters?.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = apiURL.url else {
            return nil
        }
        
        return URLRequest(url: url)
    }
    
}
