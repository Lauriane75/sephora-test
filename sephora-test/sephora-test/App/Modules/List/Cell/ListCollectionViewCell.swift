//
//  ListCollectionViewCell.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import UIKit

final class ListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet
    
    private let idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.textAlignment = .center
        idLabel.numberOfLines = 0
        idLabel.backgroundColor = .orange
        return idLabel
    }()
    
    // MARK: - Initaializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(idLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(with visibleProductItem: ProductItem) {
        idLabel.text = visibleProductItem.id
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        idLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        idLabel.frame = contentView.bounds
    }
    
}
