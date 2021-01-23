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


final class HeroListViewController: BaseViewController {
    
    
    
    //MARK: - Variables & Constants
    private let disposeBag = DisposeBag()
    
    let viewModel = HeroListViewModel()
    
    let collectionView = CollectionView()
    
    var cellSize: CGFloat {
        return screenSize.width/2.0 - 30.0
    }
    
    let cellId = "HeroCellId"
    
    
    
    
    //MARK: - View Appearence
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes".localized()
        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(cellWithClass: HeroCollectionViewCell.self)
        collectionView.register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        
        viewModel.getHeroList(page: 0)
        
        viewModel.characters.bind(to: collectionView.rx.items(cellIdentifier: self.cellId, cellType: HeroCollectionViewCell.self)) { index, character, cell in
            cell.prepareCell(character)
        }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    
    
    //MARK: - UI & Layout
    override func layoutViews() {
        view.addSubview(collectionView)
        collectionView.fillToSuperview()
    }
    
}


//MARK: - UICollectionView Delegate & DataSource
//UICollectionViewDataSource
extension HeroListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 20
//    }

//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withClass: HeroCollectionViewCell.self, for: indexPath)
//        cell.prepareCell()
//        return cell
//    }

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
