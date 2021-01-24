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
            if let heroes = event.element?.data?.results {
                if page > 0 {
//                    try! self.characters.value().append(contentsOf: )
                    print("appending")
                    do {
                        try self.characters.self.onNext(self.characters.value() + heroes) // concatenating older value with new
                    } catch {
                        print(error)
                    }
                    
                } else {
                    self.characters.onNext(heroes)
                }
            }
        }.disposed(by: disposeBag)
    }
    

}
