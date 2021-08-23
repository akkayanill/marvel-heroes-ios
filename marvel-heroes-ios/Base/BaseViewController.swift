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
import RxSwift

protocol BaseViewControllerProtocol {
    func layoutViews()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol, NVActivityIndicatorViewable {

    
    
    
    //MARK: - Variables
    let disposeBag = DisposeBag()
    
    
    
    
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
}
