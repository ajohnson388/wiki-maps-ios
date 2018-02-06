//
//  GetItemWorker.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/3/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct GetItemWorker {
    
    struct Request {
        var id: String
        var responseDispatchQueue = DispatchQueue.main
    }
    
    enum Response {
        case success(item: [String: Any])
        case error(error: Error)
    }
    
    static func getItem(withRequest request: GetItemWorker.Request,
                        responseHandler: @escaping (Response) -> Void) {
        // Dispatch to background thread
        CBLManager.sharedInstance()
            .backgroundTellDatabaseNamed(LocalDatabaseConfig.databaseName) { db in
                
                // Fetch the document from the db
                guard let json = db.existingDocument(withID: request.id)?.properties else {
                    
                    // Exit with error if document is not found
                    let error = GeneralError(localizedDescription: "404 - NOT FOUND")
                    let response = Response.error(error: error)
                    request.responseDispatchQueue.async {
                        responseHandler(response)
                    }
                    return
                }
                
                // Exit with the document
                request.responseDispatchQueue.async {
                    responseHandler(.success(item: json))
                }
        }
    }
}
