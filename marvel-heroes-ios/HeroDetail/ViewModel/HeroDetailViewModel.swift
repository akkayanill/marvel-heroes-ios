//
//  HeroDetailViewModel.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import Foundation
import UIKit


final class HeroDetailViewModel {
    
    
    //MARK: - Variables
    var character: MarvelCharacter!
    
    
    //MARK: - Endpoints
    
    
    func getEstimatedDescriptionHeight() -> CGRect{
        let size = CGSize(width: screenSize.width-40, height: 1000)
        
        if let description = self.character.description {
            print("\n\n ********** description:  \(description)")
            let estimatedFrame = NSString(string: description).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : AppFont.Regular.font(size: 12)], context: nil)
            
            return estimatedFrame
        }
        return .zero
    }
    
    
}
