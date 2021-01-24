//
//  HeroListViewController.swift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import Foundation
import UIKit
import CryptoKit
import RxSwift
import RxCocoa


final class HeroListViewController: BaseViewController {
    
    
    //MARK: - Coordinator
    var coordinatorDelegate: HeroListCoordinatorProtocol?
    
    
    
    
    //MARK: - Variables & Constants
    private let disposeBag = DisposeBag()
    
    let viewModel = HeroListViewModel()
    
    //let collectionView = CollectionView()
    let collectionView = HeroListCollectionView()
    
    var cellSize: CGFloat {
        return screenSize.width/2.0 - 30.0
    }
    
//    let cellId = "HeroCellId"
    
    var page: Int = 1
    
    
    
    
    //MARK: - View Appearence
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes".localized()
//        collectionView.delegate = self
//        collectionView.register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        addFavoritesButton()
        
        // Fetch Heroes
        viewModel.getHeroList(page: 0)
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    private func setupBindings() {
        //Loading Animation Show & Hide
        viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: self.disposeBag)
        
        
        //
        // CollectionView
        //
        // Set Collection View Info
        viewModel.characters.bind(to: collectionView.rx.items(cellIdentifier: self.collectionView.cellId, cellType: HeroCollectionViewCell.self)) { index, character, cell in
            cell.prepareCell(character)
        }.disposed(by: disposeBag)
        
        
        
        // Paging & Animation
        collectionView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.animateCell()
                
                if try! self.viewModel.loading.value() == false && indexPath.row > (Page().limit - 4) * self.page { // Can fetch the next page
                    self.viewModel.getHeroList(page: self.page)
                    self.page += 1
                }
            })).disposed(by: disposeBag)
        
        
        // Item Select
        collectionView.rx.itemSelected.subscribe(onNext:{ indexPath in
            let characters = try! self.viewModel.characters.value()
            let character = characters[indexPath.row]
            self.coordinatorDelegate?.showDetailViewController(character)
        }).disposed(by: disposeBag)
    }
    
    private func addFavoritesButton() {
        let favButton = UIButton()
        favButton.setTitle("Favorites".localized(), for: .normal)
        favButton.setTitleColor(.black, for: .normal)
        favButton.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
        let likeBarButton = UIBarButtonItem(customView: favButton)
        navigationItem.rightBarButtonItem = likeBarButton
    }
    
    @objc func favoritesButtonTapped() {
        coordinatorDelegate?.showFavoriteHeroes()
    }
    
    //MARK: - UI & Layout
    override func layoutViews() {
        view.addSubview(collectionView)
        collectionView.fillToSuperview()
    }
    
}


//MARK: - UICollectionView Delegate
//extension HeroListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: cellSize, height: cellSize+24)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 24.0
//    }
//
//}





//MARK: - Loading Extension for Loading Animations
extension Reactive where Base: BaseViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    internal var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                //vc.startAnimating()
                vc.startAnimating()
            } else {
                vc.stopAnimating()
            }
        })
    }
    
}

