//
//  HeroService.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import Foundation
import Alamofire


let baseUrl: URL = URL(string: "https://gateway.marvel.com/v1/public/")!
let PUBLIC_API_KEY = "3bb5755e17f821486088ff6e2a297e92"
let PRIVATE_API_KEY = "26c190c86a043dac1a597fb1b29bbddd52a01f7f"


//testid: 1009220
enum MarvelService: RestService {
    
    
    case characterList(page: Int)
    
    case getComics(id: Int)
    
    
    //MARK: - Rest Service
    func url() -> URL {
        let str = baseUrl.appendingPathComponent(self.path()).absoluteString.removingPercentEncoding!
        return try! str.asURL()
    }
    
    func headers() -> [String: String] {
        return [:]
    }
    
    func parameters() -> [String: AnyObject]? {
        switch self {
        case .characterList, .getComics:
            return nil
        }
    }
    
    func method() -> HTTPMethod {
        switch self {
        case .characterList, .getComics:
            return .get
        }
    }
    
    func path() -> String {
        let timestamp = Int(Date().timeIntervalSince1970)
        let hash = "\(timestamp)\(PRIVATE_API_KEY)\(PUBLIC_API_KEY)"
        
        switch self {
        case .characterList(page: let page):
            return "characters?ts=\(timestamp)&limit=\(Page().limit)&offset=\(page)&apikey=\(PUBLIC_API_KEY)&hash=\(hash.MD5)"
        case .getComics(id: let id):
            return "characters/\(id)/comics?formatType=comic&startYear=2005&orderBy=onsaleDate&limit=10&offset=0&ts=\(timestamp)&apikey=\(PUBLIC_API_KEY)&hash=\(hash.MD5)"
        }
    }
    
    func keyPath() -> String? {
        switch self {
        case .characterList, .getComics:
            return nil
        }
    }
    
    func parameterEncoding() -> ParameterEncoding {
        switch self {
        case .characterList, .getComics:
            return JSONEncoding.default
        }
    }
    
}
