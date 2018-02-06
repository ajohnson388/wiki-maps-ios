//
//  MapItem.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import Gloss

struct MapItem: LocalDocumentType {
    
    let id: String
    let type: String?
    
    var latitude: Double?
    var longitude: Double?
    
    var category: String?
    var subcategory: String?
    var tags = [String]()
    
    var title: String?
    var subtitle: String?
}


// MARK: Keys

extension MapItem {
    
    struct Keys {
        static let id = "_id"
        static let type = "type"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let category = "category"
        static let subcategory = "subcategory"
        static let tags = "tags"
        static let title = "title"
        static let subtitle = "subtitle"
    }
}


// MARK: Glossy

extension MapItem {
    
    init?(json: JSON) {
        guard let id: String = Keys.id <~~ json else {
            return nil
        }
        self.id = id
        type = Keys.type <~~ json
        latitude = Keys.latitude <~~ json
        longitude = Keys.longitude <~~ json
        category = Keys.category <~~ json
        subcategory = Keys.subcategory <~~ json
        tags = Keys.tags <~~ json ?? []
        title = Keys.title <~~ json
        subtitle = Keys.subtitle <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            Keys.id ~~> id,
            Keys.type ~~> type,
            Keys.latitude ~~> latitude,
            Keys.longitude ~~> longitude,
            Keys.category ~~> category,
            Keys.subcategory ~~> subcategory,
            Keys.tags ~~> tags,
            Keys.title ~~> title,
            Keys.subtitle ~~> subtitle
        ])
    }
}
