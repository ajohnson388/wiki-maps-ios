//
//  DeleteItemWorker.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/4/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct DeleteItemWorker {
    
    struct Request: WorkerRequest {
        var id: String
        var workerThread: DispatchQueue? = DispatchQueue.global(qos: .background)
        var responseThread: DispatchQueue? = DispatchQueue.main
    }
    
    enum Response {
        case success
        case error(error: Error)
    }
    
    static func deleteItem(withRequest request: Request,
                           responseHandler: @escaping (Response) -> Void) {
        request.asyncRequest {
            CBLManager.sharedInstance()
                .backgroundTellDatabaseNamed(LocalDatabaseConfig.databaseName) { db in
                
                // Assert the response is dispatched before exiting
                var response = Response.success
                defer {
                    request.asyncResponse(response, handler: responseHandler)
                }
                
                // Get the document
                let document = db.existingDocument(withID: request.id)
                
                // Delete the document
                do {
                    try document?.delete()
                } catch {
                    response = Response.error(error: error)
                }
            }
        }
    }
}
