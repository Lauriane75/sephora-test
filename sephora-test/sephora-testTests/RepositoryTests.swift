//
//  RepositoryTests.swift
//  sephora-testTests
//
//  Created by Lau on 28/06/2021.
//

import XCTest
@ testable import sephora_test

class RepositoryTests: XCTestCase {
    
    let client = MockHTTPClient()
    let stack = CoreDataStack(modelName: "sephora_test", type: .test)
    
    let product = ProductItem(id: "73A7F70C-75DA-4C2E-B5A3-EED40DC53AA6", description: "Description 1", location: "Location 1", image: "https://url-1.com")
    
    func test_Given_Repository_When_getProductList_Then_DataIsCorrectlyReturned() {
        
        let context = Context(client: client, stack: stack)
        let repository = Repository(context: context)

        repository.getProductList(completion: { (product) in
            switch product {
            case .success(value: let productList):
                guard let list = productList.items.first else { return }
                XCTAssertEqual(list.id, self.product.id)
                XCTAssertEqual(list.description, self.product.description)
                XCTAssertEqual(list.location, self.product.location)
                XCTAssertEqual(list.image, self.product.image)

            case .failure(error: let error):
                print(error)
            }
        }, error: { _ in
            print("error")
        })
    }
    
    
    
    
}
