//
//  HeroCollectionViewCell.swift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import UIKit


class HeroCollectionViewCell: BaseCell {
    
    
    //MARK: - Variables
    
    
    
    //MARK: - Visual Objects
    
    
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cornerRadius = 18
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Layout
    override func layoutViews() {
        
    }
}
