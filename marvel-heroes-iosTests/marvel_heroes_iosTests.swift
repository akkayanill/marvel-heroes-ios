//
//  marvel_heroes_iosTests.swift
//  marvel-heroes-iosTests
//
//  Created by Josh on 22.01.2021.
//

import XCTest
@testable import marvel_heroes_ios

class marvel_heroes_iosTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testCharacterListService() {
        XCTAssertNil(MarvelService.characterList(page: 0).parameters())
        XCTAssertNil(MarvelService.characterList(page: 0).keyPath())
        
        let timestamp = Int(Date().timeIntervalSince1970)
        let page = 0
        let hash = "\(timestamp)\(PRIVATE_API_KEY)\(PUBLIC_API_KEY)"
        XCTAssertEqual(MarvelService.characterList(page: 0).url(), URL(string: "https://gateway.marvel.com/v1/public/characters?ts=\(timestamp)&limit=\(Page().limit)&offset=\(page)&apikey=\(PUBLIC_API_KEY)&hash=\(hash.MD5)")!)
    }
    
    
    func testHeroThumbnail() {
        let thumnail = Thumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", fExtension: "jpg")
        
        let brokenThumbnail = Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", fExtension: ".jpg")
        
        XCTAssertNotEqual(brokenThumbnail.url, URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec.jpg"))
        
//        http vs https
        XCTAssertNotEqual(thumnail.url, URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec.jpg"))
    }
    
    func testTextFrame() {
        let vm = HeroDetailViewModel()
        let normalSize = vm.getEstimatedDescriptionHeight(font: AppFont.Regular.font(size: 15), text: "a")
        let doubledSize = vm.getEstimatedDescriptionHeight(font: AppFont.Regular.font(size: 15), text: "a\na")
        let thirdSize = vm.getEstimatedDescriptionHeight(font: AppFont.Regular.font(size: 15), text: "a\n\n")
        XCTAssertEqual(normalSize * 2.0, doubledSize)
        XCTAssertEqual(normalSize * 3.0, thirdSize)
    }
    
    
    func testHeroNameAndDescription() {
        let character = MarvelCharacter(id: nil, name: nil, desc: nil, thumbnail: nil)
        
        /// these shouldn't be nil.
        XCTAssertNotNil(character.name)
        XCTAssertNotNil(character.description)
    }
}
