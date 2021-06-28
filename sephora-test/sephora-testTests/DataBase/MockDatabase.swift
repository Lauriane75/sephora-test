//
//  MockDatabase.swift
//  sephora-testTests
//
//  Created by Lau on 28/06/2021.
//

import XCTest
@ testable import sephora_test

class MockDatabase: DatabaseType {
    
    // MARK: - Properties
    
    var productObjects: [ProductObject] = []
    var productItems: [ProductItem]?

    // MARK: - Get from database
    
    func getProductItems(callback: @escaping ([ProductItem]) -> Void) {
        guard productItems != nil else { return }
        callback(productItems!)
    }
    
    // MARK: - Get save in database
    
    func saveProductItems(productItems: ProductItem) {
        self.productItems = [productItems]
    }
    
    // MARK: - Delete in database
    
    func deleteAllListInDataBase() {
        self.productItems = nil
    }

}
