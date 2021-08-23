//
//  SQLiteConnection.swift
//  marvel-heroes-ios
//
//  Created by Josh on 24.01.2021.
//

import Foundation
import SQLite


class LocalDBConnection {
    
    static let shared = LocalDBConnection()
    
    private let dbName = "DB_marvel"
    private let dbFileExtension = "sqlite"
    var conn: Connection?
    
    func createLocalDBPath() {
        var path = "\(dbName).\(dbFileExtension)"
        
        let dirs: [NSString] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as [NSString]
        let dir = dirs[0]
        path = dir.appendingPathComponent("\(dbName).\(dbFileExtension)")
        print("DB path: \(path)")
        
        do {
            conn = try Connection(path)
        } catch {
            conn = nil
        }
    }
    
    func createLocalTables() {
        do {
            try FavoriteHeroesTable.create()
        } catch let error {
            print("**** LocalDBConnection.swift createLocalTables() error: \(error)")
        }
    }
    
}
