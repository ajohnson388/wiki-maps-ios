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
                    let collection = Collection(request.dataSet.domainName)
                    IndexManager.setupMapItemsCategoryView(inDatabase: db, forCollection: collection)
                    IndexManager.setupMapItemsGeoView(inDatabase: db, forCollection: collection)
                    IndexManager.setupMapItemsSearchView(inDatabase: db, forCollection: collection)
                    
                    // TODO: Run indexing if needed
                    
                    // Save each map item
                    for mapItem in request.dataSet.list {
                        let
                    }
                    
                    // Save import configs into a single collection
            }
        }
    }
    
    private static func setupViews(forDataSet dataSet: DataSet,
                                   inDatabase db: CBLDatabase) {
        let view = db.viewNamed(dataSet.domainName)
        view.documentType = dataSet.domainName
//        view.mapBlock = { doc, emitter in
//
//        }
    }
}
