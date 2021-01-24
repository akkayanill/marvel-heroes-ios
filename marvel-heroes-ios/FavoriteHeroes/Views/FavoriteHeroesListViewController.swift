//
//  FavoriteHeroesListViewController.swift
//  marvel-heroes-ios
//
//  Created by Josh on 25.01.2021.
//

import Foundation
import UIKit
import RxSwift


class FavoriteHeroesListViewController: BaseViewController {

    
    //MARK: - Coordinator
    var coordinatorDelegate: HeroListCoordinatorProtocol?
    
    
    
    
    //MARK: - Variables & Constants
    private let disposeBag = DisposeBag()
    
    let viewModel = FavoriteHeroesViewModel()
    
    let collectionView = CollectionView()
    
    var cellSize: CGFloat {
        return screenSize.width/2.0 - 30.0
    }
    
    let cellId = "HeroCellId"
    
    
    
    
    //MARK: - View Appearence
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorites".localized()
        collectionView.delegate = self
        collectionView.register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        addBackButton()
        
        // Fetch Heroes
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    private func setupBindings() {
    
        
        
        // Item Select
        collectionView.rx.itemSelected.subscribe(onNext:{ indexPath in
//            let characters = try! self.viewModel.characters.value()
//            let character = characters[indexPath.row]
//            self.coordinatorDelegate?.showDetailViewController(character)
        }).disposed(by: disposeBag)
    }
    
    
    //MARK: - UI & Layout
    override func layoutViews() {
        view.addSubview(collectionView)
        collectionView.fillToSuperview()
    }
    
}


//MARK: - UICollectionView Delegate & DataSource
extension FavoriteHeroesListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSize, height: cellSize+24)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
    }
}

