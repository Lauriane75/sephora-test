//
//  Repository.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import Foundation

protocol RepositoryType: AnyObject {
//    func getProductList(completion: @escaping (CompletionResult<Product>) -> Void, error: @escaping (String) -> Void)
}

class Repository: RepositoryType {
    
    private let token = Token()
    private let context: Context
    
    private let initialURL = "https://sephoraios.github.io/"
    
    var urlCharacter: String {
        return initialURL + "items.json"
    }
    
    // MARK: - Initializer
    
    init(context: Context) {
        self.context = context
    }

    
}

