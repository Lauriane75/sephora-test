//
//  ListCoordinator.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import UIKit

class ListViewCoordinator {
    
    // MARK: - Properties
    
    private let screens: Screens
    
    private let navigationController: UINavigationController
    
    // MARK: - Initializer
    
    init(screens: Screens, navigationController: UINavigationController) {
        self.screens = screens
        self.navigationController = navigationController
    }
}

// MARK: - CoordinatorProtocol

extension ListViewCoordinator: CoordinatorProtocol {
    
    // MARK: - Start
    
    func start() {
        createListView()
    }
    
    // MARK: - Private Functions
    
    private func createListView() {
        let viewController = screens.createListViewController(delegate: self)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    internal func createDetailView() {
        let viewController = screens.createDetailViewController(delegate: self)
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension ListViewCoordinator: ListViewModelDelegate {
    func showDetailView() {
        createDetailView()
    }
}

extension ListViewCoordinator: DetailViewModelDelegate {
   
}

