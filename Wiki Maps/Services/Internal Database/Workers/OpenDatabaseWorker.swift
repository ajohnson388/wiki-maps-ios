//
//  OpenDatabaseWorker.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/4/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

/**
    Responsible for opening the local database, and setting up intitial
    db views.
 */
struct OpenDatabaseWorker {
    
    struct Request: WorkerRequest {
        var workerThread: DispatchQueue? = DispatchQueue.global(qos: .background)
        var responseThread: DispatchQueue? = DispatchQueue.main
    }
    
    enum Response {
        case success
        case error(Error)
    }
    
    static func openDatabase(withRequest request: Request,
                             responseHandler: @escaping (Response) -> Void) {
        request.asyncRequest {
            // Assert response is dispatched before exiting
            var response = Response.success
            defer {
                request.asyncResponse(response, handler: responseHandler)
            }
            
            // Check if the database is already created
            let manager = CBLManager.sharedInstance()
            let databaseName = LocalDatabaseConfig.databaseName
            guard !manager.databaseExistsNamed(databaseName) else {
                return
            }
            
            // Open the database
            do {
                // Open the database
                let database = try manager.openDatabaseNamed(databaseName, with: nil)
                
                // Setup the initial views
                IndexManager.setupDomainNameView(inDatabase: database)
                IndexManager.setupResourceView(inDatabase: database)
                IndexManager.setupUserProfileView(inDatabase: database)
            } catch {
                response = Response.error(error)
            }
        }
    }
}






