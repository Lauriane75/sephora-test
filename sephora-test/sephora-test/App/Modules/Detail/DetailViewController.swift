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
    
    private let idLabel: CustomLabel
    
    private let productImage: UIImageView
    
    private let descriptionLabel: CustomLabel
    
    private let locationLabel: CustomLabel
    
    private let urlLabel: CustomLabel
    
    // MARK: - Properties
    
    var viewModel: DetailViewModel!
    
    // MARK: - Initializer
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        idLabel = CustomLabel(color: .black, textFont: Constant.font.font16)
        productImage = UIImageView()
        descriptionLabel = CustomLabel(color: .black, textFont: Constant.font.font16)
        locationLabel = CustomLabel(color: .black, textFont: Constant.font.font16)
        urlLabel = CustomLabel(color: .black, textFont: Constant.font.font16)
        
        stackView.addArrangedSubview(productImage)
        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(urlLabel)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setElementaddSubview()
        
        createElementsConstraints()
        
        bind(to: viewModel)
        
        viewModel.viewDidLoad()
    }
    
    // MARK: - Action
    
    // MARK: - Private Functions
    
    func setElementaddSubview() {
        view.addSubview(idLabel)
        view.addSubview(productImage)
        view.addSubview(descriptionLabel)
        view.addSubview(locationLabel)
        view.addSubview(urlLabel)
    }
    
    func createElementsConstraints() {
        // idLabel
        idLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        idLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        idLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        idLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // productImage
        productImage.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 8).isActive = true
        productImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        productImage.widthAnchor.constraint(equalTo: productImage.heightAnchor).isActive = true
        productImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.contentMode = .scaleToFill
        // descriptionLabel
        descriptionLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // locationLabel
        locationLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4).isActive = true
        locationLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // urlLabel
        urlLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 4).isActive = true
        urlLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        urlLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    fileprivate func bind(to viewModel: DetailViewModel) {
        viewModel.visibleDetailItem = { [weak self] item in
            guard let self = self else { return }
            self.idLabel.text = item.id
            self.productImage.image = UIImage(named: item.id)
            self.descriptionLabel.text = item.description
            self.locationLabel.text = item.location
            self.urlLabel.text = item.image
        }
        
    }
}
