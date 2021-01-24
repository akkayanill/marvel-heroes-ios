//
//  HeroDetailViewController.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import Foundation
import UIKit


class HeroDetailViewController: BaseViewController {
    
    
    
    //MARK: - Variable & Constants
    var cellSize: CGFloat {
        return screenSize.width/2.0 - 30.0
    }
    
    let viewModel = HeroDetailViewModel()
    
    var header: HeroDetailHeaderCell?
    
    
    
    //MARK: - Visual Objects
    let collectionView: UICollectionView = {
        let layout = CustomHeaderLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentOffset = .zero
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .white
        
        return cv
    }()
    
    
    
    //MARK: - View Appearence
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.character.name ?? "Unknown Name"
        setupCollectionView()
        addBackButton()
        header?.backgroundColor = .orange
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: HeroDetailHeaderCell.self)
        collectionView.register(cellWithClass: HeroCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    
    //MARK: - ScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        print(contentOffsetY)
        if contentOffsetY < -40 {
            header?.animator?.fractionComplete = abs(contentOffsetY) / 200
        } else {
            header?.animator?.fractionComplete = 0.0
        }
    }
    
    
    
    //MARK: - Layout
    override func layoutViews() {
        view.addSubview(collectionView)
        collectionView.fillToSuperview()
    }
}



//MARK: - Collection View Data Source & Delegate
extension HeroDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: HeroCollectionViewCell.self, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        self.header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: HeroDetailHeaderCell.self, for: indexPath)
        header?.backgroundColor = .red
        return self.header!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenSize.width, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenSize.width, height: cellSize+24)
    }
}
