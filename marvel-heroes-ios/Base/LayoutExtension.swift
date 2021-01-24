//
//  LayoutExtension.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import Foundation
import UIKit
import PureLayout


extension UIView {
    
    func fillToSuperview(inset: CGFloat) {
        if let superview = superview {
            self.autoPinEdge(.left, to: .left, of: superview, withOffset: inset)
            self.autoPinEdge(.top, to: .top, of: superview, withOffset: inset)
            
            self.autoPinEdge(.right, to: .right, of: superview, withOffset: -inset)
            self.autoPinEdge(.bottom, to: .bottom, of: superview, withOffset: -inset)
        }
    }
    
    internal func edgeHorizontal(inset: CGFloat) {
        if let superview = superview {
            self.autoPinEdge(.left, to: .left, of: superview, withOffset: inset)
            self.autoPinEdge(.right, to: .right, of: superview, withOffset: -inset)
        }
    }
    
    func edgeVertical(inset: CGFloat) {
        if let superview = superview {
            self.autoPinEdge(.top, to: .top, of: superview, withOffset: inset)
            self.autoPinEdge(.bottom, to: .bottom, of: superview, withOffset: -inset)
        }
    }
    
    func autoSetDimension(_ to: NSLayoutDimension, multiplier: CGFloat) {
        if let _ = superview {
            self.widthAnchor.constraint(equalTo: to, multiplier: multiplier).isActive = true
        }
    }
    
    
    func layoutToSuperView(to: ALEdge) {
        if let superview = superview {
            self.autoPinEdge(to, to: to, of: superview)
        }
    }
    
    func layoutToSuperView(to: ALEdge, inset: CGFloat) {
        if let superview = superview {
            self.autoPinEdge(to, to: to, of: superview, withOffset: inset)
        }
    }
}

