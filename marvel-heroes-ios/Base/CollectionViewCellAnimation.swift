//
//  CollectionViewCellAnimation.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import UIKit


extension UICollectionViewCell {
    func animateCell() {
        self.alpha = 0
//        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
//        self.layer.transform = transform
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.alpha = 1
            self.layer.transform = CATransform3DIdentity
        }, completion: nil)
    }
}
