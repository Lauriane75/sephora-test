//
//  DetailViewController.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Outlets
    
    var stackView = UIStackView()

    // MARK: - Properties
    
    var viewModel: DetailViewModel!

    // MARK: - Initializer
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
                
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        setElementaddSubview()
        
        createElementsConstraints()
        
        bind(to: viewModel)
        
        viewModel.viewDidLoad()
    }
    
    // MARK: - Action

    // MARK: - Private Functions
    
    func setElementaddSubview() {
        
    }
    
    func createElementsConstraints() {
        
    }
    
    fileprivate func bind(to viewModel: DetailViewModel) {
        
    }

    

}
