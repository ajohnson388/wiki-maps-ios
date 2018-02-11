//
//  Collection.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/10/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct Collection {
    
    enum SubTypes: String {
        case name
        case search
        case geo
    }
    
    static let domain = Collection("domain", nameKeyPath: Domain.Keys.title)
    static let userData = Collection("userData")
    static let resources = Collection("resources")
    
    let name: String
    let nameKeyPath: String?
    let geoKeyPath: String?
    
    init(_ name: String,
         nameKeyPath: String? = nil,
         geoKeyPath: String? = nil) {
        self.name = name
        self.nameKeyPath = nameKeyPath
        self.geoKeyPath = geoKeyPath
    }
}
