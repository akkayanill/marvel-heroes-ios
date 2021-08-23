//
//  FavoriteHeroesTable.swift
//  marvel-heroes-ios
//
//  Created by Josh on 24.01.2021.
//

import Foundation
import UIKit
import SQLite


typealias HeroDBModel = (
    hero_id: String?,
    recordId: Int64?,
    
    hero_name: String?,
    hero_desc: String?,
    hero_image: String?
)

class FavoriteHeroesTable {
    static let tableName = "favorites"
    static let table = Table(tableName)
    
    static let recordId = Expression<Int64>("recordId")
    static let hero_id = Expression<String>("hero_id")
    static let hero_name = Expression<String>("hero_name")
    static let hero_desc = Expression<String?>("hero_desc")
    static let hero_image_path = Expression<String?>("hero_image_path")
    static let hero_image_extension = Expression<String?>("hero_image_extension")
    
    
    static func create() throws {
        guard let database = LocalDBConnection.shared.conn else {
            throw LocalDBErrors.ConnectionError
        }
        do {
            _ = try database.run(table.create(ifNotExists: true) { t in
                t.column(recordId, primaryKey: true)
                t.column(hero_id)
                t.column(hero_name)
                t.column(hero_desc)
                t.column(hero_image_path)
                t.column(hero_image_extension)
            })
            
        } catch {
        }
    }
    
    
    static func insertHero(hero: MarvelCharacter) throws {
        guard let database = LocalDBConnection.shared.conn else {
            throw LocalDBErrors.ConnectionError
        }
        
        do {
            try database.transaction {
                try database.run(table.insert(
                                    //                                    recordId <- Int64(nextId),
                                    hero_id <- String(hero.id!),
                                    hero_name <- hero.name,
                                    hero_desc <- hero.description,
                                    hero_image_path <- hero.thumbnail!.path!,
                                    hero_image_extension <- hero.thumbnail!.fExtension))
            }
        } catch let error {
            print("insert error: \(error)")
            throw LocalDBErrors.InsertError
        }
    }
    
    static func removeHero(id: String) {
        guard let database = LocalDBConnection.shared.conn else {
            return
        }
        
        let query = "DELETE FROM favorites WHERE hero_id = '\(id)'"
        
        do {
            let _ = try database.run(query)
        } catch let error {
            print("Delete error: \(error)")
        }
    }
    
    static func isLiked(id: String) -> Statement? {
        guard let database = LocalDBConnection.shared.conn else {
            return nil
        }
        
        let query = "SELECT hero_id FROM favorites WHERE hero_id = '\(id)'"
        
        do {
            let result = try database.prepare(query)
            return result
        } catch let error {
            print("isLiked error: \(error)")
            return nil
        }
        
    }
    
    
    static func getFavoriteHeroes() -> Statement? {
        guard let database = LocalDBConnection.shared.conn else {
            return nil
        }
        
        let query = "SELECT hero_id, hero_name, hero_desc, hero_image_path, hero_image_extension FROM favorites"
        
        do {
            let result = try database.prepare(query)
            return result
        } catch let error {
            print("isLiked error: \(error)")
            return nil
        }
        
    }
    
    
}
