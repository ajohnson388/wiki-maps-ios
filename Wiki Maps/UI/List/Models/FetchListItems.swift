//
//  FetchListItems.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/11/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct FetchListItems {
    
    struct Request {
        var searchText: String? = nil
    }
    
    enum Response {
        case success
        case error(error: Error)
    }
}
