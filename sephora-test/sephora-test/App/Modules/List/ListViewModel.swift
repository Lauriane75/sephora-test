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
        
        repository.getProductList { result in
            switch result {
            case .success(value: let productItem):
                print("productItem = \(String(describing: productItem))")
            case .failure(error: let error):
                print(error.localizedDescription)
            }
        } error: { _ in
            print("call dataBase")
        }
    }
    
    func didSelectItem() {
        delegate?.showDetailView()
    }
    
}

