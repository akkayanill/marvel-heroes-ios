//
//  BaseViewModel.swift
//  marvel-heroes-ios
//
//  Created by Joshua on 23.08.2021.
//

import Foundation
import UIKit
import RxSwift

class BaseViewModel {
    let disposeBag = DisposeBag()
    let loading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
}
