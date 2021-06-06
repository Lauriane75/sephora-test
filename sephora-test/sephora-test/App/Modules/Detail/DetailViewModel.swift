//
//  DetailViewModel.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    
}

final class DetailViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: DetailViewModelDelegate?
    
    let productItem: ProductItem
    
    // MARK: - Initializer
    
    init(delegate: DetailViewModelDelegate?, productItem: ProductItem) {
        self.delegate = delegate
        self.productItem = productItem
    }
    
    // MARK: - Output
    
    var visibleDetailItem: ((ProductItem) -> Void)?
    
    // MARK: - Input
    
    func viewDidLoad() {
        visibleDetailItem?(productItem)
    }
    
}

