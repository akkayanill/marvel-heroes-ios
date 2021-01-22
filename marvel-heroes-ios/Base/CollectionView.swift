//
//  CollectionView.swift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import UIKit


class CollectionView: UICollectionView {
    
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.keyboardDismissMode = .onDrag
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
