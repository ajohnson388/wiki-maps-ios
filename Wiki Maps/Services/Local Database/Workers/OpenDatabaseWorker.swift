//
//  OpenDatabaseWorker.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/4/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct OpenDatabaseWorker {
    
    struct Request {
        
    }
    
    enum Response {
        case success
        case error(Error)
    }
    
    static func openDatabase(withRequest request: Request,
                             responseHandler: @escaping (Response) -> Void) {
        DispatchQueue.global(qos: .background).async {
            
            // Assert response is dispatched before exiting
            var response = Response.success
            defer {
                DispatchQueue.main.async {
                    responseHandler(response)
                }
            }
            
            // Check if the database is already created
            let manager = CBLManager.sharedInstance()
            let databaseName = LocalDatabaseConfig.databaseName
            guard !manager.databaseExistsNamed(databaseName) else {
                DispatchQueue.main.async {
                    responseHandler(.success)
                }
                return
            }
            
            // Open and configure the database
            do {
                try manager.openDatabaseNamed(databaseName, with: nil)
            } catch {
                response = Response.error(error)
            }
        }
        
    }
}
