//
//  BasePagination.swift
//  marvel-heroes-ios
//
//  Created by Joshua on 22.08.2021.
//

import Foundation
import UIKit


protocol BasePagination {
    var page: Int {get set}
    func checkPaging(indexPath: IndexPath)
}
