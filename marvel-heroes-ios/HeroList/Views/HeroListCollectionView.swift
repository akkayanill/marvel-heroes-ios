//
//  HeroListCollectionView.swift
//  marvel-heroes-ios
//
//  Created by Josh on 25.01.2021.
//

import Foundation
import UIKit


class HeroListCollectionView: CollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    //MARK: - Variables
    let cellId = "HeroCellId"
    
    override init() {
        super.init()
        
        delegate = self
        register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cellSize: CGFloat {
        return screenSize.width/2.0 - 30.0
    }
    
    
    
    //MARK: - UICollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSize, height: cellSize+24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
    }
    
}
