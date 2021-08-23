//
//  HeroDetailViewModel.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import Foundation
import UIKit
import RxSwift



final class HeroDetailViewModel: BaseViewModel {
    
    
    //MARK: - Variables
    var character: MarvelCharacter!
    var comics = BehaviorSubject<[ComicResults]>(value: [])
    var heroLiked: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    
    //MARK: - Functions
    func getEstimatedDescriptionHeight(width: CGFloat, font: UIFont?, text: String) -> CGFloat {
        guard let font = font else {return 0.0}
        
        let size = CGSize(width: width, height: 1000)
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return estimatedFrame.height
    }
    
    
    
    //MARK: - Requests
    func getHeroComics() {
        if let characterID = self.character.id {
            self.loading.onNext(true)
            
            MarvelService.getComics(id: characterID).request(to: ComicModel.self).subscribe { [weak self] event in
                
                self?.loading.onNext(false)
                
                if let comics = event.element?.data?.results {
                    self?.comics.onNext(comics)
                }
            }.disposed(by: disposeBag)
        } else {
            //TODO: - show alert
        }
    }
 
    
    
    //MARK: - Database
    func likeButtonTapped() {
        if didCharacterLiked() == true { // Already liked, Remove now
            removeFromFavorites()
        } else { // Like
            addFavorites()
        }
    }
    
    private func addFavorites() {
        if let _ = self.character.id {
            try? FavoriteHeroesTable.insertHero(hero: self.character)
        }
    }
    
    private func removeFromFavorites() {
        if let id = self.character.id {
            try? FavoriteHeroesTable.removeHero(id: "\(id)")
        }
    }
    
    ///Checks if the Character liked before.
    func didCharacterLiked() -> Bool {
        if let id = self.character.id {
            guard let result = try? FavoriteHeroesTable.isLiked(id: "\(id)") else { return false }
            
            var favArr = [String]()
            for row in result {
                favArr.append(row[0] as! String)
            }
            
            if favArr.count > 0 {
                return true
            } else {
                return false
            }
        }
        return false
    }

}
