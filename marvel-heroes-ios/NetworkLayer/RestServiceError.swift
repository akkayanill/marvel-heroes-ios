//
//  RestServiceError.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import Foundation

public enum RestServiceError: Error {
    case unknownError
    case retryError
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
    
    static func getErrorType(_ statusCode: Int) -> RestServiceError {
        switch statusCode {
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 409:
            return .conflict
        case 500:
            return .internalServerError
        default:
            return .unknownError
        }
    }
    
}
