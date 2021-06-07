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
        let database = Database(context: context)
        let viewModel = ListViewModel(delegate: delegate, repository: repository, database: database)
        viewController.viewModel = viewModel
        return viewController
    }
    
    func createDetailViewController(delegate: DetailViewModelDelegate?, productItem: ProductItem) -> UIViewController {
        let viewController = DetailViewController()
        let viewModel = DetailViewModel(delegate: delegate, productItem: productItem)
        viewController.viewModel = viewModel
        return viewController
    }
}
