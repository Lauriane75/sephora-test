//
//  Repository.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import CoreData
import Foundation

protocol RepositoryType: AnyObject {
    func getProductList(completion: @escaping (CompletionResult<Product>) -> Void, error: @escaping (String) -> Void)
    
    func saveProductItems(productItems: ProductItem)
    func deleteAllListInDataBase()
    func getProductItems(callback: @escaping ([ProductItem]) -> Void)
}

class Repository: RepositoryType {
    
    private let token = Token()
    private let context: Context
    private var productObjects: [ProductObject] = []
    
    // MARK: - Initializer
    
    init(context: Context) {
        self.context = context
    }
    
    func getProductList(completion: @escaping (CompletionResult<Product>) -> Void, error: @escaping (String) -> Void) {
        
        let urlString = "https://sephoraios.github.io/items.json"
        
        guard let url = URL(string: urlString) else { return }
        
        context.client.request(type: Product.self, endPointType: .GET, url: url, cancelledBy: token) { product in
            switch product {
            case .success(value: let productItem):
                let result: Product = productItem
                completion(.success(value: result))
            case .failure(error: let onError):
                error(onError.localizedDescription)
                print("error = \(String(describing: error))")
            }
        }
    }
    
    func saveProductItems(productItems: ProductItem) {
        let productObject = ProductObject(context: context.stack.context)
        productObject.idProduct = productItems.id
        productObject.descriptionProduct = productItems.description
        productObject.locationProduct = productItems.location
        productObject.imageUrlProduct = productItems.image

        context.stack.saveContext()
    }

    func deleteAllListInDataBase() {
        let requestProduct: NSFetchRequest<ProductObject> = ProductObject.fetchRequest()
        guard let productListItems = try? self.context.stack.context.fetch(requestProduct) else { return }
        guard !productListItems.isEmpty else { return }
        self.productObjects = productListItems
        self.productObjects.enumerated().forEach { (_, object) in
            self.context.stack.context.delete(object)
            self.context.stack.saveContext()
        }
    }

    func getProductItems(callback: @escaping ([ProductItem]) -> Void) {
        let requestProduct: NSFetchRequest<ProductObject> = ProductObject.fetchRequest()
        guard let productItems = try? context.stack.context.fetch(requestProduct) else { return }
        self.productObjects = productItems
        let product: [ProductItem] = productItems.map { return ProductItem(object: $0) }
        callback(product)
    }
}

