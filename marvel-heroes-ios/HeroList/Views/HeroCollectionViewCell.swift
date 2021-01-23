//
//  HeroCollectionViewswift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import UIKit


class HeroCollectionViewCell: BaseCell {
    
    
    //MARK: - Variables
    
    
    
    //MARK: - Visual Objects
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    private let nameLabel = Label(font: AppFont.SemiBold.font(size: 18), textColor: .black, textAlignment: .left, numberOfLines: 1)
    
    
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutViews()
        self.backgroundColor = .white
        cornerRadius = 10
        borderWidth = 1.5
        borderColor = UIColor(hexString: "#199CFF")!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareCell() {
        imageView.image = UIImage(named: "hero_dummy")
        nameLabel.text = "Hero Name"
    }
    
    
    //MARK: - UI & Layout
    override func layoutViews() {
        contentView.addSubview(imageView)
        imageView.layoutToSuperView(to: .top)
        imageView.layoutToSuperView(to: .bottom, inset: -32)
        imageView.edgeHorizontal(inset: 0)
        

        contentView.addSubview(nameLabel)
        nameLabel.layoutToSuperView(to: .bottom, inset: -6)
        nameLabel.edgeHorizontal(inset: 8)
    }
}
