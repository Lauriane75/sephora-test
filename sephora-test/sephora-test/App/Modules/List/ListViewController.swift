//
//  ViewController.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - Outlets
    
    var stackView = UIStackView()
    
    private let button: CustomButton

    // MARK: - Properties
    
    var viewModel: ListViewModel!

    // MARK: - Initializer
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        button = CustomButton(textColor: .white, withBackgroundColor: .black, font: Constant.font.font16, cornerRadius: 15)
        
        stackView.addArrangedSubview(button)
                
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        setElementaddSubview()
        
        createElementsConstraints()
        
        bind(to: viewModel)
        
        viewModel.viewDidLoad()
    }
    
    // MARK: - Action
    
    @objc func didPressButton() {
        viewModel.didSelectItem()
    }

    // MARK: - Private Functions
    
    func setElementaddSubview() {
        view.addSubview(button)
        
    }
    
    func createElementsConstraints() {
        // titleLabel
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
    }
    
    fileprivate func bind(to viewModel: ListViewModel) {
        viewModel.labelText = { [weak self] text in
            self?.button.setTitle(text, for: .normal)
        }
        
    }

}

