//
//  HeroListCoordinator.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import Foundation
import UIKit

protocol HeroListCoordinatorProtocol: class {
    func showDetailViewController()
    func backToHeroList()
}

class HeroListCoordiantor: Coordinator, HeroListCoordinatorProtocol {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HeroListViewController()
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    
    //TODO: - add model or id argument to func.
    func showDetailViewController() {
//        let vc =
//        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func backToHeroList() {
        
    }
}


