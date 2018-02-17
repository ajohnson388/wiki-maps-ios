//
//  View.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/17/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

enum View: String {
    case empty, geo, category, search, name
    
    func getName(forCollection collection: Collection) -> String {
        return collection.name + self.rawValue
    }
}
