//
//  ViewController.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import UIKit
import RxCocoa
import RxSwift

class ListViewController: UIViewController {
    
    // MARK: - Outlets
    
    private let collectionView: CustomCollectionView
    
    // MARK: - Properties
    
    var viewModel: ListViewModel!
    
    private var listCollectionViewDataSource = ListCollectionViewDataSource()
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.collectionView = CustomCollectionView(frame: .zero, collectionViewLayout: ListViewController.createLayout())
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        viewModel.viewDidLoad()
//        bind(to: viewModel)
    
        bindViewModel()
        setupView()
        
        bind(to: listCollectionViewDataSource)
    }
    
    // MARK: - Action
    
    
    // MARK: - Private Functions
    
    private func setupView() {
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "ListCollectionViewCell")
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .white
        collectionView.dataSource = listCollectionViewDataSource
        collectionView.delegate = listCollectionViewDataSource
        
        setElementaddSubview()
    }
    
    func bindViewModel() {
        let viewDidLoad = rx
            .viewIsLoaded
        
        let inputs = ListViewModel.Inputs(
            viewDidLoad: viewDidLoad
        )
        
        let outputs = viewModel.transform(inputs: inputs)
        
        outputs
            .visibleProductItem
            .asDriver(onErrorJustReturn: [ProductItem]())
            .drive(onNext: { [weak self] item in
                guard let self = self else { return }
                self.listCollectionViewDataSource.update(with: item)
            })
            .disposed(by: disposeBag)
    }
    
    func setElementaddSubview() {
        view.addSubview(collectionView)
    }
    
    fileprivate func bind(to viewModel: ListViewModel) {
        
        viewModel.visibleProductItem = { [weak self] item in
            guard let self = self else { return }
            self.listCollectionViewDataSource.update(with: item)
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func bind(to source: ListCollectionViewDataSource) {
        source.selectedItem = viewModel.didSelectItem
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        // item
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/3),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2, leading: 2, bottom: 2, trailing: 2
        )
        
        let itemTriple = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                                                    widthDimension: .fractionalWidth(1/3),
                                                    heightDimension: .fractionalHeight(1)))
        
        let verticalStackItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.5)
            )
        )
        verticalStackItem.contentInsets = NSDirectionalEdgeInsets(
            top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let verticalStackGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1)),
            subitem: verticalStackItem,
            count: 2)
        
        // group
        
        let tripleHorizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize:  NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/3)),
            subitem: itemTriple,
            count: 3
        )
        
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(2/3)
            ),
            subitems: [
                item,
                verticalStackGroup
            ]
        )
        
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(3/5)
            ),
            subitems: [horizontalGroup, tripleHorizontalGroup]
        )
        
        // sections
        let section = NSCollectionLayoutSection(group: verticalGroup)
        
        // return
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}

public extension Reactive where Base: UIViewController {
    var viewIsLoaded: Observable<Void> {
        base.rx.sentMessage(#selector(UIViewController.viewWillAppear(_:))).map { _ in }.take(1)
    }
}
