//
//  ListCollectionViewDataSource.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import UIKit

class ListCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Private properties
    
    private var items: [ProductItem] = []
    
    var selectedItem: ((Int) -> Void)?
    
    // MARK: Public function
    
    func update(with items: [ProductItem]) {
        self.items = items
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard items.count > indexPath.item else {
            return UICollectionViewCell() // Should be monitored
        }
        let visibleCharacter = items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell",
                                                      for: indexPath)
            as! ListCollectionViewCell
        cell.configure(with: visibleCharacter)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < items.count else { return }
        selectedItem?(indexPath.row)
    }
}

