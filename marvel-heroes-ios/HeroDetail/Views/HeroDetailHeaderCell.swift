//
//  HeroDetailHeaderCell.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import Foundation
import UIKit


class HeroDetailHeaderCell: UICollectionViewCell {
    
    
    public var animator: UIViewPropertyAnimator?
    
    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.backgroundColor = .clear
        imgView.image = UIImage(named: "hero_dummy")
        
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layoutViews() {
        addSubview(imageView)
        imageView.fillToSuperview()
    }
    
    // MARK:- add visual effect view
    private func addBlurVisulaEffectView() {
        
        animator = UIViewPropertyAnimator(duration: 4.0, curve: .easeInOut, animations: { [weak self] in
            guard let strongSelf = self else { return }
            
            let blurEffect = UIBlurEffect(style: .regular)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            visualEffectView.translatesAutoresizingMaskIntoConstraints = false
            strongSelf.addSubview(visualEffectView)
            visualEffectView.fillToSuperview()
        })
    }
}



//MARK: - CustomHeaderLayout
class CustomHeaderLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attribute) in
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader {
                
                guard let collectionView = collectionView else { return }
                let contentOffsetY = collectionView.contentOffset.y
                
                if contentOffsetY < 0 {
                    let width = collectionView.frame.width
                    
                    let height = attribute.frame.height - contentOffsetY
                    attribute.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
                }
            }
        })
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
