//
//  NavigationController.swift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import UIKit


extension UIViewController {
    
    public func addBackButton() {
        let backButton = UIButton()
        let arrowImage = UIImage(named: "back")
        backButton.setImage(arrowImage, for: .normal)
        backButton.addTarget(self, action: #selector(backToVC), for: .touchUpInside)
        let backBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButton
    }
    
    @objc func backToVC() {
        navigationController?.popViewController(animated: true)
    }
    
    public func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: AppFont.Bold.font(size: 20), NSAttributedString.Key.foregroundColor: UIColor.black]
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .white
    
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    
}
