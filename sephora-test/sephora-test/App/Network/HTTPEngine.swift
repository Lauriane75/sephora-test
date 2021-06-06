//
//  HTTPEngine.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import Foundation

typealias HTTPCompletionHander = (Data?, HTTPURLResponse?, Error?) -> Void

enum URLSessionEngineError: Error {
    case invalidURLResponseType
}

final class HTTPEngine {

    // MARK: - Properties

    private let session: URLSession

    // MARK: - Initializer

    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }

    func send(request: URLRequest,
              cancelledBy token: Token,
              completion: @escaping HTTPCompletionHander) {
        let task = session.dataTask(with: request) { (data, urlResponse, _) in
            if urlResponse != nil, let httpURLResponse = urlResponse as? HTTPURLResponse {
                completion(data, httpURLResponse, nil)
            } else {
                completion(data, nil, URLSessionEngineError.invalidURLResponseType)
            }
        }
        task.resume()
        token.willDealocate = {
            task.cancel()
        }
    }

    deinit {
        session.invalidateAndCancel()
    }
}

