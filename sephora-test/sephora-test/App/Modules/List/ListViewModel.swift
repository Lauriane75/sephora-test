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

final class DetailViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: ListViewModelDelegate?
    
    // MARK: - Initializer
    
    init(delegate: ListViewModelDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - Output
    
    var labelText: ((String) -> Void)?
    
    // MARK: - Input
    
    func didSelectItem() {
        delegate?.showDetailView()
    }
    
}

