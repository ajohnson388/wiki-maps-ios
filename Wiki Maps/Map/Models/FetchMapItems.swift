//
//  FetchMapItems.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct FetchMapItems {
    
    struct Request {
        var categories: [String]?
        var geobox: Rectangle?
    }
    
    enum Response {
        case success(mapItems: [MapItem])
        case error(error: Error)
    }
}
