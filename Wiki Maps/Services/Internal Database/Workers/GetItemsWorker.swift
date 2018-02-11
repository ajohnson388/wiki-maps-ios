//
//  GetItemsWorker.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/3/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct GetItemsWorker {
    
    struct Request: WorkerRequest {
        var geobox: Rectangle?
        var workerThread: DispatchQueue? = DispatchQueue.global(qos: .background)
        var responseThread: DispatchQueue? = DispatchQueue.main
    }
    
    enum Response {
        case success(items: [[String: Any]]?)
        case error(error: Error)
    }
    
    static func getItems(withRequest request: Request,
                         responseHandler: (Response) -> Void) {
        request.asyncRequest {
            CBLManager.sharedInstance()
                .backgroundTellDatabaseNamed(LocalDatabaseConfig.databaseName) { db in
                    
                    // TODO: Implement
            }
        }
    }
}
