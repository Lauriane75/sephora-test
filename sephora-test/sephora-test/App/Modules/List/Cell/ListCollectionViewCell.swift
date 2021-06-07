//
//  ListCollectionViewCell.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import UIKit

final class ListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
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
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(with visibleProductItem: ProductItem) {
        imageView.image = UIImage(named: visibleProductItem.id)
        idLabel.text = visibleProductItem.id
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        idLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        idLabel.frame = contentView.bounds
    }
    
}
