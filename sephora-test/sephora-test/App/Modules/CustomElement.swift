//
//  CustomElement.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import UIKit

class CustomLabel: UILabel {
    convenience init(color: UIColor, textFont: UIFont) {
        self.init()
        textColor = color
        font = textFont
        numberOfLines = 0
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
}

class CustomButton: UIButton {
    convenience init(textColor: UIColor, withBackgroundColor: UIColor?, font: UIFont, cornerRadius: CGFloat?) {
        self.init()
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = font
        backgroundColor = withBackgroundColor
        layer.cornerRadius = cornerRadius ?? 0
        translatesAutoresizingMaskIntoConstraints = false
    }
}

class CustomCollectionView: UICollectionView {
    convenience init(uiBackGroundColor: UIColor) {
        self.init()
        backgroundColor = uiBackGroundColor
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
    }
}
