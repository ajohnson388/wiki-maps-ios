//
//  OpenDatabaseWorker.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/4/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

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
            
            // Open and configure the database
            do {
                try manager.openDatabaseNamed(databaseName, with: nil)
            } catch {
                response = Response.error(error)
            }
        }
    }
    
    static func setupSearchView(inDatabase db: CBLDatabase,
                                forCollection collection: Collection,
                                version: Int) {
        let viewName = Collection.SubTypes.search.rawValue + collection.name
        let view = db.viewNamed(viewName)
        view.documentType = collection.name
        view.setMapBlock({ doc, emit in
            guard
            let nameKeyPath = collection.nameKeyPath,
            let name = doc.valueForKeyPath(keyPath: nameKeyPath) as? String else {
                emit("", nil)
                return
            }
            emit(name, nil)
        }, version: "\(version)")
    }
    
    static func setupNameView(inDatabase db: CBLDatabase,
                          forCollection collection: Collection,
                          version: Int) {
        let viewName = Collection.SubTypes.name.rawValue + collection.name
        let view = db.viewNamed(viewName)
        view.documentType = collection.name
        view.setMapBlock({ doc, emit in
            guard
            let nameKeyPath = collection.nameKeyPath,
            let name = doc.valueForKeyPath(keyPath: nameKeyPath) as? String else {
                emit("", nil)
                return
            }
            emit(name, nil)
        }, version: "\(version)")
    }
}
