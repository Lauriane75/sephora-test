//
//  MockHTTPClient.swift
//  sephora-testTests
//
//  Created by Lau on 28/06/2021.
//

import XCTest
@ testable import sephora_test

class MockHTTPClient: HTTPClientType {
    
    func request<T>(type: T.Type, endPointType: EndPointType, url: URL, cancelledBy token: Token, completion: @escaping (CompletionResult<T>) -> Void) where T : Decodable {
        do {
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            guard let decodedData = try? jsonDecoder.decode(type.self, from: data) else { return }
            completion(.success(value: decodedData))
        } catch {
            completion(.failure(error: error)
       )}
    }
}
