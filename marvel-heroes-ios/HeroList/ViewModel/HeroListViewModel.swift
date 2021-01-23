//
//  HeroListViewModel.swift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import UIKit
import RxSwift


final class HeroListViewModel {
    
  
    //MARK: - Variables
    private let disposeBag = DisposeBag()
    
    let loading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    //var characters = PublishSubject<[MarvelCharacter]>()
    var characters = BehaviorSubject<[MarvelCharacter]>(value: [])
    
    
    
    //MARK: - Functions
    func getHeroList(page: Int) {
        self.loading.onNext(true)
        
        HeroService.characterList(page: page).request(to: HeroModel.self).subscribe { event in
            
            self.loading.onNext(false)
            if let characters = event.element?.data?.results {
                self.characters.onNext(characters)
            }
        }.disposed(by: disposeBag)
    }
    

}
