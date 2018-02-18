//
//  Resource.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/18/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import Gloss

/**
    A model for resource documents such as maps and markers.
 */
struct Resource: LocalDocumentType {
    
    var id: String
    var type: String?
    var domainName: String?
    var subtype: Subtype
    var imageData: String
}


// MARK: - Glossy

extension Resource {
    
    init?(json: JSON) {
        guard
        let id: String = Keys.id <~~ json,
        let subtype: Subtype = Keys.subtype <~~ json,
        let imageData: String = Keys.imageData <~~ json else {
            return nil
        }
        
        self.id = id
        self.type = Collection.resources.name
        self.subtype = subtype
        self.imageData = imageData
        domainName = Keys.domainName <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            Keys.id ~~> id,
            Keys.type ~~> type,
            Keys.subtype ~~> subtype,
            Keys.imageData ~~> imageData,
            Keys.domainName ~~> domainName
        ])
    }
}


// MARK: - Inner Types

extension Resource {
    
    enum Subtype: String {
        case map, marker
    }
    
    struct Keys {
        static let id = "_id"
        static let type = "type"
        static let subtype = "subtype"
        static let domainName = "domainName"
        static let imageData = "imageData"
    }
}
