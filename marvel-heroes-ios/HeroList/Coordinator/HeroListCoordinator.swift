//
//  HeroListCoordinator.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import Foundation
import UIKit

protocol HeroListCoordinatorProtocol: class {
    func showDetailViewController(_ character: MarvelCharacter)
    func backToHeroList()
}



final class HeroListCoordiantor: Coordinator, HeroListCoordinatorProtocol {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HeroListViewController()
        vc.coordinatorDelegate = self
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetailViewController(_ character: MarvelCharacter) {
        let vc = HeroDetailViewController()
        vc.viewModel.character = character
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func backToHeroList() {
        navigationController.popViewController(animated: true)
    }
}


