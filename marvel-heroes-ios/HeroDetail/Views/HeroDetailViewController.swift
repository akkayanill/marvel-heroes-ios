//
//  HeroDetailViewController.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import Foundation
import UIKit


final class HeroDetailViewController: BaseViewController {
    
    
    
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
        
        setupCollectionView()
        addBackButton()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTransparentNavigationBar()
    }
    
    private func setupCollectionView() {
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: HeroDetailHeaderCell.self)
        collectionView.register(cellWithClass: HeroCollectionViewCell.self)
        collectionView.register(cellWithClass: HeroInformationCell.self)
        
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let informationCell = collectionView.dequeueReusableCell(withClass: HeroInformationCell.self, for: indexPath)
        informationCell.prepareCell(viewModel: self.viewModel)
        informationCell.backgroundColor = .orange
        return informationCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        self.header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: HeroDetailHeaderCell.self, for: indexPath)
        header?.prepareCell(viewModel: viewModel)
        
        return self.header!
    }
    
    // Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return .zero
        }
        return CGSize(width: screenSize.width, height: screenSize.width+45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let estimatedFrame = self.viewModel.getEstimatedDescriptionHeight()
        print("estimatedFrame: \(estimatedFrame.height)")
        
        if indexPath.section == 0 {
            return CGSize(width: screenSize.width-40, height: estimatedFrame.height + 40)
        }
        
        return CGSize(width: screenSize.width, height: estimatedFrame.height + 40)
        
    }
}
