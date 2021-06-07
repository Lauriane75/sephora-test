//
//  ListViewModel.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    func showDetailView(item: ProductItem)
    
}

final class ListViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: ListViewModelDelegate?
    
    private let repository: RepositoryType
    
    private let database: DatabaseType
    
    
    private var productItems: [ProductItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.visibleProductItem?(self.productItems)
            }
        }
    }
    
    // MARK: - Initializer
    
    init(delegate: ListViewModelDelegate?, repository: RepositoryType, database: DatabaseType) {
        self.delegate = delegate
        self.repository = repository
        self.database = database
    }
    
    // MARK: - Output
    
    var visibleProductItem: (([ProductItem]) -> Void)?
    
    // MARK: - Input
    
    func viewDidLoad() {
        repository.getProductList { result in
            switch result {
            case .success(value: let productList):
                self.deleteAllDataBase()
                productList.items.enumerated().forEach { _, item in
                    let productItem = ProductItem(items: item)
                    self.productItems.append(productItem)
                    self.saveInDataBase(productItem)
                }
            case .failure(error: let error):
                print(error.localizedDescription)
            }
        } error: { [weak self] _ in
            guard let self = self else { return }
            self.getFromDatabase()
        }
    }
    
    func didSelectItem(at index: Int) {
        guard !self.productItems.isEmpty, index < self.productItems.count else { return }
        let item = self.productItems[index]
        delegate?.showDetailView(item: item)
    }
    
    // MARK: - Private Functions
    
    fileprivate func deleteAllDataBase() {
        DispatchQueue.main.async {
            self.database.deleteAllListInDataBase()
        }
    }
    
    fileprivate func saveInDataBase(_ productItem: ProductItem) {
        DispatchQueue.main.async {
            self.database.saveProductItems(productItems: productItem)
        }
    }
    
    fileprivate func getFromDatabase() {
        DispatchQueue.main.async {
            self.database.getProductItems { result in
                guard !result.isEmpty else {
                    print("error")
                    return
                }
                self.productItems = result
            }
        }
    }
}

