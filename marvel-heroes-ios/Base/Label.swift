//
//  Label.swift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import UIKit

class Label: UILabel {
    
    init(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment, numberOfLines: Int?) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.adjustsFontSizeToFitWidth = false
        
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines ?? 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

