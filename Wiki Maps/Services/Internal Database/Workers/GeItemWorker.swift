//
//  GetItemWorker.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/3/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct GetItemWorker {
    
    struct Request: WorkerRequest {
        var id: String
        var workerThread: DispatchQueue? = DispatchQueue.global(qos: .background)
        var responseThread: DispatchQueue? = DispatchQueue.main
    }
    
    enum Response {
        case success(item: [String: Any])
        case error(error: Error)
    }
    
    static func getItem(withRequest request: Request,
                        responseHandler: @escaping (Response) -> Void) {
        request.asyncRequest {
            CBLManager.sharedInstance()
                .backgroundTellDatabaseNamed(LocalDatabaseConfig.databaseName) { db in
                    
                    // Fetch the document from the db
                    guard let json = db.existingDocument(withID: request.id)?.properties else {
                        
                        // Exit with error if document is not found
                        let error = GeneralError("File not found")
                        let response = Response.error(error: error)
                        request.asyncResponse(response, handler: responseHandler)
                        return
                    }
                    
                    // Exit with the document
                    request.asyncResponse(Response.success(item: json),
                                          handler: responseHandler)
            }
        }
    }
}
