//
//  DeleteItemWorker.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/4/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct DeleteItemWorker {
    
    struct Request {
        var id: String
        var responseDispatchQueue = DispatchQueue.main
    }
    
    enum Response {
        case success
        case error(error: Error)
    }
    
    static func deleteItem(withRequest request: DeleteItemWorker.Request,
                           responseHandler: @escaping (DeleteItemWorker.Response) -> Void) {
        CBLManager.sharedInstance().backgroundTellDatabaseNamed(LocalDatabaseConfig.databaseName) {
            db in
            
            // Assert the response is dispatched before exiting
            var response = DeleteItemWorker.Response.success
            defer {
                request.responseDispatchQueue.async {
                    responseHandler(response)
                }
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
