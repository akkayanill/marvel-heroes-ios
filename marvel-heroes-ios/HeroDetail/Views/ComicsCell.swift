//
//  ComicsCell.swift
//  marvel-heroes-ios
//
//  Created by Josh on 24.01.2021.
//

import Foundation
import UIKit
import TTTAttributedLabel

final class ComicsCell: UICollectionViewCell {

    
    
    //MARK: - Visual Objects
    private var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.cornerRadius = 6
        return imgView
    }()
    
    
    private var nameLabel: TTTAttributedLabel = {
        let label = TTTAttributedLabel(frame: .zero)
        label.verticalAlignment = .center
        label.font = AppFont.SemiBold.font(size: 12)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 3

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
    
    
    func prepareCell(comic: ComicResults) {
        nameLabel.text = comic.title
        imageView.kf.setImage(with: comic.thumbnail?.url)
    }
    
    
    //MARK: - Layout
    private func layoutViews() {
        addSubview(imageView)
        imageView.edgeHorizontal(inset: 0)
        imageView.layoutToSuperView(to: .top)
        imageView.layoutToSuperView(to: .bottom,inset: -60)
        
        addSubview(nameLabel)
        nameLabel.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 2)
        nameLabel.edgeHorizontal(inset: 0)
        nameLabel.layoutToSuperView(to: .bottom)
    }
    
}
