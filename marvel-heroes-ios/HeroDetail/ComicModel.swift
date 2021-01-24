//
//  ComicModel.swift
//  marvel-heroes-ios
//
//  Created by Josh on 24.01.2021.
//

import Foundation
import ObjectMapper

struct ComicModel : Mappable {
    var code : Int?
    var status : String?
    var copyright : String?
    var attributionText : String?
    var attributionHTML : String?
    var etag : String?
    var data : ComicData?

    init?(map: Map) {}

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

struct ComicData : Mappable {
    var offset : Int?
    var limit : Int?
    var total : Int?
    var count : Int?
    var results : [ComicResults]?

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

struct ComicResults : Mappable {
    var id : Int?
    var digitalId : Int?
    var title : String?
    var issueNumber : Int?
    var variantDescription : String?
    var description : String?
    var modified : String?
    var isbn : String?
    var upc : String?
    var diamondCode : String?
    var ean : String?
    var issn : String?
    var format : String?
    var pageCount : Int?
    var textObjects : [String]?
    var resourceURI : String?
    var urls : [Urls]?
    var series : Series?
    var variants : [String]?
    var collections : [String]?
//    var collectedIssues : [CollectedIssues]?
//    var dates : [Dates]?
//    var prices : [Prices]?
    var thumbnail : Thumbnail?
//    var images : [Images]?
//    var creators : Creators?
//    var characters : Characters?
    var stories : Stories?
    var events : Events?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        digitalId <- map["digitalId"]
        title <- map["title"]
        issueNumber <- map["issueNumber"]
        variantDescription <- map["variantDescription"]
        description <- map["description"]
        modified <- map["modified"]
        isbn <- map["isbn"]
        upc <- map["upc"]
        diamondCode <- map["diamondCode"]
        ean <- map["ean"]
        issn <- map["issn"]
        format <- map["format"]
        pageCount <- map["pageCount"]
        textObjects <- map["textObjects"]
        resourceURI <- map["resourceURI"]
        urls <- map["urls"]
        series <- map["series"]
        variants <- map["variants"]
        collections <- map["collections"]
//        collectedIssues <- map["collectedIssues"]
//        dates <- map["dates"]
//        prices <- map["prices"]
        thumbnail <- map["thumbnail"]
//        images <- map["images"]
//        creators <- map["creators"]
//        characters <- map["characters"]
        stories <- map["stories"]
        events <- map["events"]
    }

}
