//
//  HTTPClient.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import Foundation

enum CompletionResult<T> {
    case success(value: T)
    case failure(error: Error)
}

enum NetworkError: Error {
    case unknown
}

protocol HTTPClientType {
    func request<T>(type: T.Type,
                    endPointType: EndPointType,
                    url: URL,
                    cancelledBy token: Token,
                    completion: @escaping (CompletionResult<T>) -> Void) where T: Decodable
}

enum EndPointType: String {
    case GET
    case POST
}

final class HTTPClient: HTTPClientType {

    // MARK: - Properties

    private let engine: HTTPEngine

    private let jsonDecoder: JSONDecoder

    // MARK: - Initializer

    init(engine: HTTPEngine = HTTPEngine.init(configuration: .default)) {
        self.engine = engine
        self.jsonDecoder = JSONDecoder()
    }

    func request<T>(type: T.Type,
                    endPointType: EndPointType,
                    url: URL,
                    cancelledBy token: Token,
                    completion: @escaping (CompletionResult<T>) -> Void) where T: Decodable {
        var request = URLRequest(url: url)
        request.httpMethod = endPointType.rawValue
        engine.send(request: request, cancelledBy: token) { (data, _, error) in
            if let error = error {
                completion(.failure(error: error))
            } else if let data = data {
                guard let result = try? self.jsonDecoder.decode(T.self, from: data) else { return }
                completion(.success(value: result))
            } else {
                completion(.failure(error: NetworkError.unknown))
            }
        }
    }
}
