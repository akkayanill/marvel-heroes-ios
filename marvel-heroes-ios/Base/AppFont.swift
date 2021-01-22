//
//  AppFont.swift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import UIKit


enum AppFont: String {
    case Light = "Rubik-Light"
    case Regular = "Rubik-Regular"
    case Medium = "Rubik-Medium"
    case SemiBold = "Rubik-SemiBold"
    case Bold = "Rubik-Bold"
    case Black = "Rubik-Black"
    
    public func font(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}


