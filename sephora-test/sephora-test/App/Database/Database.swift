//
//  Database.swift
//  sephora-test
//
//  Created by Lau on 07/06/2021.
//

import CoreData
import Foundation

protocol DatabaseType: AnyObject {
    
    func saveProductItems(productItems: ProductItem)
    func deleteAllListInDataBase()
    func getProductItems(callback: @escaping ([ProductItem]) -> Void)
}

class Database: DatabaseType {
    
    private let context: Context
    private var productObjects: [ProductObject] = []
    
    // MARK: - Initializer
    
    init(context: Context) {
        self.context = context
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

