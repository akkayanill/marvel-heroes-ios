//
//  HeroModel.swift
//  marvel-heroes-ios
//
//  Created by Josh on 23.01.2021.
//

import Foundation
import ObjectMapper


//MARK: - HeroModel

struct HeroModel : Mappable {
    var code : Int?
    var status : String?
    var copyright : String?
    var attributionText : String?
    var attributionHTML : String?
    var etag : String?
    var data : Data?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        code <- map["code"]
        status <- map["status"]
        copyright <- map["copyright"]
        attributionText <- map["attributionText"]
        attributionHTML <- map["attributionHTML"]
        etag <- map["etag"]
        data <- map["data"]
    }
    
}



//MARK: - Results
struct MarvelCharacter : Mappable {
    var id : Int?
    var name : String {
        if heroName == "" || heroName == nil {
            return "Hero name is not available".localized()
        } else {
            return heroName!
        }
    }
    var description: String {
        if desc == "" || desc == nil {
            return "Description is not available".localized()
        } else {
            return desc!
        }
    }
    private var heroName: String?
    private var desc : String?
    var modified : String?
    var thumbnail : Thumbnail?
    var resourceURI : String?
    var comics : Comics?
    var series : Series?
    var stories : Stories?
    var events : Events?
    var urls : [Urls]?
    
    
    init(id: Int?, name: String?, desc: String?, thumbnail: Thumbnail?) {
        self.id = id
        self.heroName = name
        self.desc  = desc
        self.thumbnail = thumbnail
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        heroName <- map["name"]
        desc <- map["description"]
        modified <- map["modified"]
        thumbnail <- map["thumbnail"]
        resourceURI <- map["resourceURI"]
        comics <- map["comics"]
        series <- map["series"]
        stories <- map["stories"]
        events <- map["events"]
        urls <- map["urls"]
    }
    
}



//MARK: - Series
struct Series : Mappable {
    var available : Int?
    var collectionURI : String?
    var items : [Items]?
    var returned : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        available <- map["available"]
        collectionURI <- map["collectionURI"]
        items <- map["items"]
        returned <- map["returned"]
    }
    
}



//MARK: - Stories
struct Stories : Mappable {
    var available : Int?
    var collectionURI : String?
    var items : [Items]?
    var returned : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        available <- map["available"]
        collectionURI <- map["collectionURI"]
        items <- map["items"]
        returned <- map["returned"]
    }
    
}



//MARK: - Thumbnail
struct Thumbnail : Mappable {
    var path : String?
    var fExtension : String?
    
    init(path: String, fExtension: String) {
        self.path = path
        self.fExtension = fExtension
    }
    
    var url: URL? {
        get {
            guard let path = path, let fExtension = fExtension else { return nil }
            let url = URL(string: "\(path).\(fExtension)")
            return url
        }
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        path <- map["path"]
        fExtension <- map["extension"]
    }
    
}



//MARK: - Urls
struct Urls : Mappable {
    var type : String?
    var url : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        type <- map["type"]
        url <- map["url"]
    }
    
}



//MARK: - Comics
struct Comics : Mappable {
    var available : Int?
    var collectionURI : String?
    var items : [Items]?
    var returned : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        available <- map["available"]
        collectionURI <- map["collectionURI"]
        items <- map["items"]
        returned <- map["returned"]
    }
    
}



//MARK: - Data
struct Data : Mappable {
    var offset : Int?
    var limit : Int?
    var total : Int?
    var count : Int?
    var results : [MarvelCharacter]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        offset <- map["offset"]
        limit <- map["limit"]
        total <- map["total"]
        count <- map["count"]
        results <- map["results"]
    }
    
}



//MARK: - Events
struct Events : Mappable {
    var available : Int?
    var collectionURI : String?
    var items : [Items]?
    var returned : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        available <- map["available"]
        collectionURI <- map["collectionURI"]
        items <- map["items"]
        returned <- map["returned"]
    }
    
}



//MARK: - Items
struct Items : Mappable {
    var resourceURI : String?
    var name : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        resourceURI <- map["resourceURI"]
        name <- map["name"]
    }
    
}
