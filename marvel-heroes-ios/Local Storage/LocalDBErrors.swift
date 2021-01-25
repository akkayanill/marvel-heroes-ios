//
//  LocalDBErrors.swift
//  marvel-heroes-ios
//
//  Created by Josh on 24.01.2021.
//

import Foundation


enum LocalDBErrors: Error {
  case ConnectionError
  case InsertError
  case DeleteError
  case NilData
}
