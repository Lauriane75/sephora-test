//
//  MockRepository.swift
//  sephora-testTests
//
//  Created by Lau on 28/06/2021.
//

import XCTest
@ testable import sephora_test

class MockRepository:
    RepositoryType {
    
    // MARK: - Properties

    var productList: Product?
    var isSuccess = true
    var onError: Error?

    // MARK: - Get from network
    
    func getProductList(completion: @escaping (CompletionResult<Product>) -> Void, error: @escaping (String) -> Void) {
        if isSuccess {
            guard let productList = productList else { return }
            completion(.success(value: productList))
        } else {
            guard let error = onError else { return }
            completion(.failure(error: error))
        }
    }
}
