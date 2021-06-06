//
//  ListViewModel.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    func showDetailView()
}

final class ListViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: ListViewModelDelegate?
    
    private let repository: RepositoryType
    
    // MARK: - Initializer
    
    init(delegate: ListViewModelDelegate?, repository: RepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }
    
    // MARK: - Output
    
    var labelText: ((String) -> Void)?
    
    // MARK: - Input
    
    func viewDidLoad() {
        labelText?("ListView")

        repository.getProduct { result in
            switch result {
            case .success(let productItem):
                print("productItem = \(String(describing: productItem))")
                print("product count = \(String(describing: productItem.first?.items.count))")

            case .failure(let error):
                print("error = \(error.localizedDescription)")
            }
        }
    }
    
    func didSelectItem() {
        delegate?.showDetailView()
    }
    
}

