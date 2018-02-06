//
//  SaveItemWorker.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/4/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct SaveItemWorker {
    
    struct Request {
        var id: String
        var json: [String: Any]  // The properties to be updated
        var responseDispatchQueue = DispatchQueue.main
    }
    
    enum Response {
        case success
        case error(error: Error)
    }
    
    static func saveItem(withRequest request: SaveItemWorker.Request,
                         responseHandler: @escaping (SaveItemWorker.Response) -> Void) {
        CBLManager.sharedInstance()
            .backgroundTellDatabaseNamed(LocalDatabaseConfig.databaseName) { db in
                
                // Assert response is dispatch before the worker finishes
                var response = Response.success
                defer {
                    request.responseDispatchQueue.async {
                        responseHandler(response)
                    }
                }
            
                // Get or create the document
                let document = db.document(withID: request.id)
                
                do {
                    // Add or replace the properties
                    try document?.update { revision in
                        revision.properties?.addEntries(from: request.json)
                        return true
                    }
                } catch {
                    response = SaveItemWorker.Response.error(error: error)
                }
        }
    }
}
