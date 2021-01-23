//
//  HeroListViewModel.swift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import UIKit
import RxSwift


class HeroListViewModel {
    
  
    //MARK: - Variables
    private let disposeBag = DisposeBag()
    
    var characters = PublishSubject<[MarvelCharacter]>()
    
    
    
    //MARK: - Functions
    func getHeroList(page: Int) {
        HeroService.characterList(page: page).request(to: HeroModel.self).subscribe { event in
            
            if let characters = event.element?.data?.results {
                self.characters.onNext(characters)
            }
        }.disposed(by: disposeBag)
    }
    

}
