//
//  HeroListViewController.swift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import Foundation
import UIKit


class HeroListViewController: BaseViewController {
    
    
    
    //MARK: - Variables
    let collectionView = CollectionView()
    
    var cellSize: CGFloat {
        return screenSize.width/2.0 - 30.0
    }
    
    
    
    //MARK: - View Appearence
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.title = "Heroes".localized()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellWithClass: HeroCollectionViewCell.self)
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


extension HeroListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: HeroCollectionViewCell.self, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0
    }
    
    
    
}
