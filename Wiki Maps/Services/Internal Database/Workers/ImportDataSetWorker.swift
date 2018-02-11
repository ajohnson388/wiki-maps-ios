//
//  ImportDataSetWorker.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/4/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation


/**
    The local db will consist of 4 collections.
    Data sets, configs, resources, and user data.
 */

struct ImportDataSetWorker {
    
    struct Request: WorkerRequest {
        var dataSet: DataSet
        var workerThread: DispatchQueue?
        var responseThread: DispatchQueue? = DispatchQueue.main
    }
    
    enum Response {
        case success
        case error(error: Error)
    }
    
    static func importDataSet(withRequest request: Request,
                              responseHandler: @escaping (Response) -> Void) {
        request.asyncRequest {
            CBLManager.sharedInstance()
                .backgroundTellDatabaseNamed(LocalDatabaseConfig.databaseName) { db in
                    
                    // Create the view(s) for the data set
                    
                    // Run indexing if needed
                    
                    // Save each map item into a game-specific collection
                    
                    // Save import configs into a single collection
            }
        }
    }
    
    private static func setupViews(forDataSet dataSet: DataSet,
                                   inDatabase db: CBLDatabase) {
        let view = db.viewNamed(dataSet.type)
        view.documentType = dataSet.type
//        view.mapBlock = { doc, emitter in
//
//        }
    }
}
