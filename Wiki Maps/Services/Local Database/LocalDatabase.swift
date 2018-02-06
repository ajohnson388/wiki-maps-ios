//
//  LocalDatabase.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/3/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import Gloss

/**
    A singleton used to access the local database from a worker
    thread. All callbacks will return on the main thread.
 */
final class LocalDatabaseWorker {

    private let dbName = "wiki_db"
    
    init() {
        
    }
    
    /**
        Convenient wrapper for doing database work.
     */
    private func startWork(_ handler: @escaping (CBLDatabase) -> Void) {
        CBLManager.sharedInstance()
            .backgroundTellDatabaseNamed(dbName, to: handler)
    }
    
    private func finishWork(_ handler: @escaping () -> Void) {
        DispatchQueue.main.async(execute: handler)
    }
}

// MARK: Getters

extension LocalDatabaseWorker {
    
    
    func get<T>(itemWithId id: String,
                callback: @escaping (T?) -> Void) where T: JSONDecodable  {
        startWork { db in
            guard let json = db.existingDocument(withID: id)?.properties else {
                self.finishWork { callback(nil) }
                return
            }
            let item = T(json: json)
            self.finishWork { callback(item) }
        }
    }
    
    func getItems<T>(inGeobox geobox: Rectangle, callback: @escaping ([T]?) -> Void) where T: JSONDecodable {
        
    }
}


// MARK: Setters

extension LocalDatabaseWorker {
    
    func saveItem<T>(_ item: T, callback: @escaping (Bool) -> Void) where T: LocalDocumentType {
        guard let json = item.toJSON() else {
            callback(false)
            return
        }
        
        startWork { db in
            // Get or create the document
            let document = db.document(withID: item.id)
            
            // Add the properties
            do {
                try document?.update { revision in
                    revision.properties?.addEntries(from: json)
                    return true
                }
            } catch {
                
            }

        }
    }
}


// MARK: Destructors

