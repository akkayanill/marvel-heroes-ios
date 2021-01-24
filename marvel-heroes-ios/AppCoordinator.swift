//
//  AppCoordinator.swift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import UIKit


class AppCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let heroListChild = HeroListCoordiantor(navigationController: self.navigationController)
        childCoordinators.append(heroListChild)
        heroListChild.start()
    }
    
}


