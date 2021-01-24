//
//  HeroDetailViewModel.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import Foundation
import UIKit
import RxSwift



final class HeroDetailViewModel {
    
    
    //MARK: - Variables
    private let disposeBag = DisposeBag()
    var character: MarvelCharacter!
    let loading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var comics = BehaviorSubject<[ComicResults]>(value: [])
    var heroLiked: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var alert: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    
    //MARK: - Functions
    func getEstimatedDescriptionHeight() -> CGRect{
        let size = CGSize(width: screenSize.width-40, height: 1000)
        
        let description = self.character.description
        //            print("\n\n ********** description:  \(description)")
        let estimatedFrame = NSString(string: description).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : AppFont.Regular.font(size: 12)], context: nil)
        
        return estimatedFrame
    }
    
    
    
    //MARK: - Requests
    func getHeroComics() {
        if let characterID = self.character.id {
            self.loading.onNext(true)
            
            MarvelService.getComics(id: characterID).request(to: ComicModel.self).subscribe { event in
                
                self.loading.onNext(false)
                
                if let comics = event.element?.data?.results {
                    self.comics.onNext(comics)
                    //                    comics.forEach { (mc) in
                    //                        print("*********** name: \(mc.title ?? "unknown") *********")
                    //                    }
                }
            }.disposed(by: disposeBag)
        } else {
            //TODO: - show alert
        }
    }
 
    
    
    //MARK: - Database
    func likeButtonTapped() {
        if didCharacterLiked() == true { // Already liked, now remove
            removeFromFavorites()
        } else { // like!! <3
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
            
            print("favArr: \(favArr.count)")
            if favArr.count > 0 {
                return true
            } else {
                return false
            }
        }
        return false
    }

}
