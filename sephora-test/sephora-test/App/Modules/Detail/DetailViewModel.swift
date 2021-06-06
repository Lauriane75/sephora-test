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
        
    // MARK: - Initializer
    
    init(delegate: DetailViewModelDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - Output
    
    var labelText: ((String) -> Void)?
    
    // MARK: - Input
    
    func viewDidLoad() {
        labelText?("DetailView")
    }
    
  
    
}

