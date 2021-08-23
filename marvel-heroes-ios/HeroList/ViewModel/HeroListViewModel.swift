//
//  HeroListViewModel.swift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import UIKit
import RxSwift


final class HeroListViewModel: BasePagination {
    
    
    
    //MARK: - BasePagination
    var page: Int = 0
    
    func checkPaging(indexPath: IndexPath) {
        
        if try! (self.loading.value() == false) && indexPath.row > (Page().limit - 4) * self.page { // Can fetch the next page
            self.page += 1
            self.getHeroList(page: self.page)
        }
    }
    
    
    
  
    //MARK: - Variables
    private let disposeBag = DisposeBag()
    
    
//    var heroListNetworkResult = PublishSubject<NetworkResult>()
    let loading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    var characters = BehaviorSubject<[MarvelCharacter]>(value: [])
    
    
    
    //MARK: - Functions
    func getHeroList(page: Int) {
//        heroListNetworkResult.onNext(NetworkResult(isLoading: true, error: nil))
        if page == 0 {
            self.loading.onNext(true)
        }
        
        MarvelService.characterList(page: page).request(to: HeroModel.self).subscribe { [weak self] event in
            guard let _ = self else {return}
            self!.loading.onNext(false)
            
            if let heroes = event.element?.data?.results {
                if page > 0 {
                    do {
//                        self!.heroListNetworkResult.onNext(NetworkResult(isLoading: false, error: nil))
                        try self!.characters.onNext(self!.characters.value() + heroes) // concatenating older value with new
                    } catch let error {
//                        self?.heroListNetworkResult.onNext(NetworkResult(isLoading: false, error: error))
                        print(error)
                    }
                    
                } else {
                    self!.characters.onNext(heroes)
                }
            }
        }.disposed(by: disposeBag)
    }
    

}
