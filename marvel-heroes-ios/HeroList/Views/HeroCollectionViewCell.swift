//
//  HeroCollectionViewswift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import UIKit
import Kingfisher
import TTTAttributedLabel


class HeroCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: - Variables
    
    
    
    //MARK: - Visual Objects
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    private let blackBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.cornerRadius = 24
        
        return view
    }()
    
    private let nameLabel: TTTAttributedLabel = {
        let label = TTTAttributedLabel(frame: .zero)
        label.verticalAlignment = .center
        label.font = AppFont.SemiBold.font(size: 15)
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
        cornerRadius = 10
        borderWidth = 1.5
        borderColor = UIColor(hexString: "#199CFF")!
        imageView.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func prepareCell(_ character: MarvelCharacter) {
        let name = character.name ?? "Name Unavailable".localized()
        nameLabel.text = name
        
        if let url = character.thumbnail?.url {
            imageView.kf.setImage(with: url)
        }
    }
    
    
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{
                UIView.animate(withDuration: 0.55, delay: 0.05, options: .curveEaseOut, animations: {
                    self.imageView.transform = .init(scaleX: 0.95, y: 0.95)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.5, delay: 0.05, options: .curveEaseOut, animations: {
                    self.imageView.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                }, completion: nil)
            }
        }
    }
    
    
    
    //MARK: - UI & Layout
    private func layoutViews() {
        contentView.addSubview(imageView)
        imageView.layoutToSuperView(to: .top, inset: -12)
        imageView.layoutToSuperView(to: .bottom, inset: 12)
        imageView.edgeHorizontal(inset: -12)
        
        
        contentView.addSubview(blackBottomView)
        blackBottomView.layoutToSuperView(to: .bottom, inset: 54)
        blackBottomView.edgeHorizontal(inset: 0)
        blackBottomView.autoSetDimension(.height, toSize: 54*2)
        
        contentView.addSubview(nameLabel)
        nameLabel.layoutToSuperView(to: .bottom, inset: -6)
        nameLabel.autoSetDimension(.height, toSize: 40)
        nameLabel.edgeHorizontal(inset: 10)
    }
}
