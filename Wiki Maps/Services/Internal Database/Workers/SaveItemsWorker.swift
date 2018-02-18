//
//  SaveItemsWorker.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/4/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct SaveItemsWorker {
    
    struct Request: WorkerRequest {
        
        typealias Item = (id: String, properties: [String: Any])
        
        var items: [Item]
        var workerThread: DispatchQueue? = DispatchQueue.global(qos: .background)
        var responseThread: DispatchQueue? = DispatchQueue.main
        
        init(_ items: [Item]) {
            self.items = items
        }
        
        init(id: String, properties: [String: Any]) {
            let item = Item(id: id, properties: properties)
            items = [item]
        }
    }
    
    enum Response {
        case success
        case error(error: Error)
    }
    
    static func saveItems(withRequest request: Request,
                         responseHandler: @escaping ([Response]) -> Void) {
        request.asyncRequest {
            CBLManager.sharedInstance()
                .backgroundTellDatabaseNamed(LocalDatabaseConfig.databaseName) { db in
                    
                    // Assert response is dispatch before the worker finishes
                    var responses = [Response]()
                    defer {
                        request.asyncResponse(responses, handler: responseHandler)
                    }
                    
                    // Save each item
                    for item in request.items {
                        
                        // Get or create the document
                        let document = db.document(withID: item.id)
                        
                        do {
                            // Add or replace the properties
                            try document?.update { revision in
                                revision.properties?
                                    .addEntries(from: item.properties)
                                return true
                            }
                            responses.append(Response.success)
                        } catch {
                            let response = Response.error(error: error)
                            responses.append(response)
                        }
                    }
            }
        }
    }
}
