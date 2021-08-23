//
//  HeroInformationCell.swift
//  marvel-heroes-ios
//
//  Created by Josh on 24.01.2021.
//

import Foundation
import UIKit


final class HeroInformationCell: UICollectionViewCell {
    
    
    //MARK: - Visual Object
    var descFont: UIFont = AppFont.Regular.font(size: 12)
    lazy private var nameLabel = Label(font: AppFont.Bold.font(size: 18), textColor: .black, textAlignment: .left, numberOfLines: 1)
    
    lazy private var descLabel = Label(font: AppFont.Regular.font(size: 12), textColor: .black, textAlignment: .left, numberOfLines: 0)
    
    
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        layoutViews()
        backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        descLabel.font = descFont
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    func prepareCell(viewModel: HeroDetailViewModel) {
        let name = viewModel.character.name ?? "Name is not available".localized()
        nameLabel.text = name
        descLabel.text = viewModel.character.description
    }
    
    
    
    //MARK: - Layout
    private func layoutViews() {
        addSubview(nameLabel)
        nameLabel.layoutToSuperView(to: .top, inset: 8)
        nameLabel.autoSetDimension(.height, toSize: 24)
        nameLabel.edgeHorizontal(inset: 0)
        
        addSubview(descLabel)
        descLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 6)
        descLabel.edgeHorizontal(inset: 0)
        descLabel.layoutToSuperView(to: .bottom, inset: -10)
    }
}
