//
//  LabelCollectionViewCell.swift
//  marvel-heroes-ios
//
//  Created by Josh on 24.01.2021.
//

import Foundation
import UIKit


final class LabelCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: - Visual Objects
    private let comicsLabel = Label(font: AppFont.Bold.font(size: 18), textColor: .black, textAlignment: .left, numberOfLines: 1)
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutViews()
        comicsLabel.text = "Comics".localized()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layoutViews() {
        addSubview(comicsLabel)
        comicsLabel.edgeHorizontal(inset: 0)
        comicsLabel.layoutToSuperView(to: .top)
    }
}
