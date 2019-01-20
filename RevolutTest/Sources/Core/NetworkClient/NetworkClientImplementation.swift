//
//  NetworkClientImplementation.swift
//  RevolutTest
//
//  Created by Gregory Oberemkov on 05/01/2019.
//  Copyright © 2019 Gregory Oberemkov. All rights reserved.
//

import Foundation

enum NetworkClientErrors: Error {
    case connectionError
    case wrongData
}

final class NetworkClientImplementation {

    static let shared = NetworkClientImplementation(session: customURLSession)

    // MARK: - Private propertes

    private let session: URLSession

    // MARK: - Init

    init(session: URLSession) {
        self.session = session
    }
}

// MARK: - NetworkClient

extension NetworkClientImplementation: NetworkClient {

    func fetchRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T>) -> Void) {

        session.dataTask(with: request) { (data, _, error) in

            if error != nil {
                completion(.error(NetworkClientErrors.connectionError))
            }

            if let data = data {
                do {
                    let resultData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(resultData))
                } catch {
                    completion(.error(NetworkClientErrors.wrongData))
                }
            } else {
                completion(.error(NetworkClientErrors.wrongData))
            }

        }.resume()

    }

}

// MARK: - Extension

private extension NetworkClientImplementation {

    static let customURLSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(15)
        configuration.timeoutIntervalForResource = TimeInterval(15)
        return URLSession(configuration: configuration)
    }()

}
