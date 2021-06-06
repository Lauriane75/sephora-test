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
    
    private var productItems: [ProductItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.visibleProductItem?(self.productItems)
            }
        }
    }
    
    // MARK: - Initializer
    
    init(delegate: ListViewModelDelegate?, repository: RepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }
    
    // MARK: - Output
    
    var visibleProductItem: (([ProductItem]) -> Void)?
    
    // MARK: - Input
    
    func viewDidLoad() {
        repository.getProductList { result in
            switch result {
            case .success(value: let productList):
                productList.items.enumerated().forEach { _, item in
                    self.productItems.append(ProductItem(items: item))
                }
            case .failure(error: let error):
                print(error.localizedDescription)
            }
        } error: { _ in
            print("call dataBase = core data")
        }
    }
    
    func didSelectItem(at index: Int) {
        guard !self.productItems.isEmpty, index < self.productItems.count else { return }
        let item = self.productItems[index]
        delegate?.showDetailView(item: item)
    }
}

