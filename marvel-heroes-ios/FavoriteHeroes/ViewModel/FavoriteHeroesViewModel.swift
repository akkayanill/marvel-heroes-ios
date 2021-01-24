//
//  FavoriteHeroesViewModel.swift
//  marvel-heroes-ios
//
//  Created by Josh on 25.01.2021.
//

import Foundation
import UIKit
import RxSwift

class FavoriteHeroesViewModel {
    
    
    //MARK: - Variables
    var characters = BehaviorSubject<[MarvelCharacter]>(value: [])
    
    
    //MARK: - Database
    func getFavoriteHeroesList() {
        if let result = FavoriteHeroesTable.getFavoriteHeroes() {
            var characters = [MarvelCharacter]()
            for row in result {
//                print("hero name: \(row[1] as! String)")
//                print("hero url: \(row[3] as! String)")
                characters.append(MarvelCharacter(id: Int(row[0] as! String)!, name: row[1] as! String, desc: row[2] as! String, image: row[3] as! String))
            }
            self.characters.onNext(characters)
        }
    }
    
}


extension MarvelCharacter {
    
}
