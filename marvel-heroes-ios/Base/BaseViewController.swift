//
//  BaseViewController.swift
//  marvel-heroes-ios
//
//  Created by Josh on 22.01.2021.
//

import UIKit
import SwifterSwift
import NVActivityIndicatorView
import PureLayout

protocol BaseViewControllerProtocol: class {
    func layoutViews()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol, NVActivityIndicatorViewable {

    
    //MARK: - Variables
    
    
    //MARK: - View Appearence
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        layoutViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    
    //MARK: - UI & Layout
    func layoutViews() {}
    
    
//    @objc func dismissVC() {
//        self.view.endEditing(true)
//        self.dismiss(animated: true, completion: nil)
//    }
    
}
