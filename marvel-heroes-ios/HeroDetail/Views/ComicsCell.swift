//
//  ComicsCell.swift
//  marvel-heroes-ios
//
//  Created by Josh on 24.01.2021.
//

import Foundation
import UIKit
import TTTAttributedLabel

class ComicsCell: UICollectionViewCell {

    
    
    //MARK: - Visual Objects
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "comic-dummy")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        
        return imgView
    }()
    
    private let nameLabel: TTTAttributedLabel = {
        let label = TTTAttributedLabel(frame: .zero)
        label.verticalAlignment = .center
        label.font = AppFont.SemiBold.font(size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2

        return label
    }()
    
    
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        layoutViews()
        self.backgroundColor = .white
        self.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Layout
    private func layoutViews() {
        addSubview(imageView)
        imageView.edgeHorizontal(inset: 0)
        imageView.layoutToSuperView(to: .top)
        
        addSubview(nameLabel)
        nameLabel.layoutToSuperView(to: .bottom)
        nameLabel.edgeHorizontal(inset: 6)
        nameLabel.autoSetDimension(.height, toSize: 40)
    }
    
}
