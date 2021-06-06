//
//  Screens.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import UIKit

class Screens {
    
    // MARK: - Properties

    private let context: Context
    
    // MARK: - Initializer

    init(context: Context) {
        self.context = context
    }
    
    func createListViewController(delegate: ListViewModelDelegate?) -> UIViewController {
        let viewController = ListViewController()
        let repository = Repository(context: context)
        let viewModel = ListViewModel(delegate: delegate, repository: repository)
        viewController.viewModel = viewModel
        return viewController
    }
    
    func createDetailViewController(delegate: DetailViewModelDelegate?) -> UIViewController {
        let viewController = DetailViewController()
        let viewModel = DetailViewModel(delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
    

}
