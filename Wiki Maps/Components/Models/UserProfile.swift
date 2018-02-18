//
//  UserProfile.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/18/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import Gloss

struct UserProfile: LocalDocumentType {
    
    var id: String
    var type: String? = Collection.userData.name
    
    var name: String
    var domainName: String
}


// MARK: - Glossy

extension UserProfile {
    
    init?(json: JSON) {
        guard
        let id: String = Keys.id <~~ json,
        let name: String = Keys.name <~~ json,
        let domainName: String = Keys.domainName <~~ json else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.domainName = domainName
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            Keys.id ~~> id,
            Keys.type ~~> type,
            Keys.name ~~> name,
            Keys.domainName ~~> domainName
        ])
    }
}


// MARK: - Keys

extension UserProfile {
    
    struct Keys {
        static let id = "_id"
        static let type = "type"
        static let name = "name"
        static let domainName = "domainName"
    }
}
