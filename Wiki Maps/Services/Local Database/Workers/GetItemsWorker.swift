//
//  GetItemsWorker.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/3/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct GetItemsWorker {
    
    struct Request {
        var geobox: Rectangle?
    }
    
    enum Response {
        case success(items: [[String: Any]]?)
        case error(error: Error)
    }
    
//    static func getItems(withRequest request: GetItems.Request,
//                         responseHandler: (Response) -> Void) {
//        CBLManager.sharedInstance()
//            .backgroundTellDatabaseNamed(LocalDatabaseConfig.databaseName) { db in
//            
//                // TODO: Implement
//        }
//    }
}
