//
//  Coordinator.swift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import UIKit


protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        print("before child count: \(childCoordinators.count)")
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                print("after child count: \(childCoordinators.count)")
                break
            }
        }
    }
}
