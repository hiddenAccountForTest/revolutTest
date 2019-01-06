//
//  NetworkClient.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 05/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation

protocol NetworkClient {
    func fetchRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T>) -> Void)
}
