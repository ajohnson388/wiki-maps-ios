//
//  DataSet.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/10/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import Gloss

struct DataSet {
    
    var type: String
    var list: [MapItem]
}


// MARK: - Keys

extension DataSet {
    
    struct Keys {
        static let type = "type"
        static let list = "list"
    }
}


// MARK: - Glossy

extension DataSet: Glossy {
    
    init?(json: JSON) {
        guard let type: String = Keys.type <~~ json else {
            return nil
        }
        self.type = type
        list = Keys.list <~~ json ?? []
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            Keys.type ~~> type,
            Keys.list ~~> list
        ])
    }
}
