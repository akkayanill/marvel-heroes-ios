//
//  BaseCell.swift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//


import UIKit

public class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func layoutViews() {
        
    }
    
}
