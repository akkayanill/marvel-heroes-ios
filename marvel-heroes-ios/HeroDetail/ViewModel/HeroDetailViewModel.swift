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
//    var alert: BehaviorSubject<Bool>?
    
    
    
    //MARK: - Functions
    func getEstimatedDescriptionHeight() -> CGRect{
        let size = CGSize(width: screenSize.width-40, height: 1000)
        
        if let description = self.character.description {
//            print("\n\n ********** description:  \(description)")
            let estimatedFrame = NSString(string: description).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : AppFont.Regular.font(size: 12)], context: nil)
            
            return estimatedFrame
        }
        return .zero
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
    
}
