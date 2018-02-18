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
                    let items: [SaveItemsWorker.Request.Item] = request.dataSet.list.flatMap {
                        guard let properties = $0.toJSON() else {
                            return nil
                        }
                        return SaveItemsWorker.Request
                            .Item(id: $0.id, properties: properties)
                    }
                    var saveRequest = SaveItemsWorker.Request(items)
                    saveRequest.workerThread = nil
                    saveRequest.responseThread = nil
                    SaveItemsWorker.saveItems(withRequest: saveRequest) { responses in
                        // Handler errors if any
                        let generalError = GeneralError("Failed to save items")
                        var importResponse = Response.error(error: generalError)
                        for response in responses {
                            switch response {
                            case .success:
                                importResponse = Response.success
                                break
                            case .error(let error):
                                // TODO: Handle when logger is integrated
                                break
                            }
                        }
                        
                        request.asyncResponse(importResponse,
                                              handler: responseHandler)
                    }
                    
                    
                    // Save import configs into a single collection
            }
        }
    }
}
