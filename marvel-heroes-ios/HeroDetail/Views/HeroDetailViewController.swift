//
//  HeroDetailViewController.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import Foundation
import UIKit
import RxSwift


final class HeroDetailViewController: BaseViewController {
    
    
    
    //MARK: - Variable & Constants
    
    //Cells
    var informationCell: HeroInformationCell?
    var comicTextCell: LabelCollectionViewCell?
    
    var coordinatorDelegate: HeroListCoordiantor!
    
    var comicsCellSize: CGFloat {
        return screenSize.width/2.0 - 30.0
    }
    
    let viewModel = HeroDetailViewModel()
    
    var header: HeroDetailHeaderCell?
    
    
    
    //MARK: - Visual Objects
    let favoriteButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
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
        addLikeButton()
        
        self.title = viewModel.character.name
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        
        updateLikeButton(isLiked: viewModel.didCharacterLiked())
        viewModel.getHeroComics()
        setupBindings()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    override func backToVC() {
        self.coordinatorDelegate.backToHeroList()
    }
    
    private func setupBindings() {
        viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: self.disposeBag)
        
        let _ = viewModel.comics.subscribe { [weak self] event in
            self?.collectionView.reloadData()
        }
    }
    
    
    
    //MARK: - NavigationBar
    private func addLikeButton() {
        favoriteButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        let likeBarButton = UIBarButtonItem(customView: favoriteButton)
        navigationItem.rightBarButtonItem = likeBarButton
    }
    
    private func updateLikeButton(isLiked: Bool) {
        if isLiked {
            favoriteButton.setImage(UIImage(named: "liked")!, for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "like")!, for: .normal)
        }
    }
    
    @objc func likeButtonTapped() {
        viewModel.likeButtonTapped()
        updateLikeButton(isLiked: viewModel.didCharacterLiked())
    }
    
    
    //MARK: - CollectionView
    private func setupCollectionView() {
        collectionView.register(supplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: HeroDetailHeaderCell.self)
        collectionView.register(cellWithClass: HeroCollectionViewCell.self)
        collectionView.register(cellWithClass: HeroInformationCell.self)
        collectionView.register(cellWithClass: LabelCollectionViewCell.self)
        collectionView.register(cellWithClass: ComicsCell.self)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    
    //MARK: - ScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 { // Comics
            let count = try? viewModel.comics.value().count
            return count ?? 0
        }
        
        return 1
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 { // Hero Information
            self.informationCell = collectionView.dequeueReusableCell(withClass: HeroInformationCell.self, for: indexPath)
            informationCell!.prepareCell(viewModel: self.viewModel)
            
            return informationCell!
            
        } else if indexPath.section == 1 { // Comics Label
            comicTextCell = collectionView.dequeueReusableCell(withClass: LabelCollectionViewCell.self, for: indexPath)
            let comicCount = (try? viewModel.comics.value().count) ?? 0
            comicTextCell!.prepareCell(comicCount: comicCount)

            return comicTextCell!
            
        } else { // Comics
            let comicsCell = collectionView.dequeueReusableCell(withClass: ComicsCell.self, for: indexPath)
            if let comics = try? viewModel.comics.value() {
                comicsCell.prepareCell(comic: comics[indexPath.row])
            }
            return comicsCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 1 { // Comics Text Label
            return UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        } else if section == 2 { // Comics
            return UIEdgeInsets(top: 6, left: 20, bottom: 24, right: 20)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        self.header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withClass: HeroDetailHeaderCell.self, for: indexPath)
        header?.prepareCell(viewModel: viewModel)
        
        return self.header!
    }
    
    // Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: screenSize.width, height: screenSize.width+45)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let estimatedFrame = self.viewModel.getEstimatedDescriptionHeight(width: screenSize.width-40, font: self.informationCell?.descFont, text: viewModel.character.description)
        
        if indexPath.section == 0 { // Hero information
            return CGSize(width: screenSize.width-40, height: estimatedFrame + 60)
        } else if indexPath.section == 1 { // Comics Label
            return CGSize(width: screenSize.width-40, height: 24)
        } else { // Comics
            return CGSize(width: comicsCellSize, height: comicsCellSize+75)
        }
    }
}
