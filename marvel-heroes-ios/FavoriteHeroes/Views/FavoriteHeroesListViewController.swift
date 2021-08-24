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
    private let viewModel = FavoriteHeroesViewModel()
    
    var collectionView = HeroListCollectionView()
    
    private var cellSize: CGFloat {
        return screenSize.width/2.0 - 30.0
    }
    
    
    
    //MARK: - View Appearence
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorites".localized()

        addBackButton()
        
        // Fetch Heroes
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
        
        viewModel.getFavoriteHeroesList()
    }
    
    private func setupBindings() {
        viewModel.characters.bind(to: collectionView.rx.items(cellIdentifier: self.collectionView.cellId, cellType: HeroCollectionViewCell.self)) { index, character, cell in
            cell.prepareCell(character)
        }.disposed(by: disposeBag)
        
        // Item Select
        collectionView.rx.itemSelected.subscribe(onNext:{ indexPath in
            let characters = try! self.viewModel.characters.value()
            let character = characters[indexPath.row]
            self.coordinatorDelegate?.showDetailViewController(character)
        }).disposed(by: disposeBag)
    }
    
    
    //MARK: - UI & Layout
    override func layoutViews() {
        view.addSubview(collectionView)
        collectionView.fillToSuperview()
    }
    
}
