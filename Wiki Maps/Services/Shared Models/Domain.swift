//
//  Domain.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/10/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import Gloss

struct Domain: LocalDocumentType {
    
    var id: String
    var type: String? = "domain"
    
    /**
        Used in the UI to identify the different domains.
     */
    var title: String
    
    /**
        A url to the associated map data hosted remotely. This url
        points a json file.
     */
    var dataSetLink: URL
    
    /**
        Used to identify the collection the domain's associated
        map data is stored in.
     */
    var dataSetType: String
    
    var createdDate: Date
    var lastModifiedDate: Date
    var contributors: [String]
}


// MARK: - Keys

extension Domain {
    
    struct Keys {
        static let id = "id"
        static let type = "type"
        static let title = "title"
        static let dataSetType = "dataSetType"
        static let dataSetLink = "dataSetLink"
        static let createdDate = "createdDate"
        static let lastModifiedDate = "lastModifiedDate"
        static let contributors = "contributors"
    }
}


// MARK: - Glossy

extension Domain: Glossy {
    
    init?(json: JSON) {
        guard
        let id: String = Keys.id <~~ json,
        let type: String = Keys.type <~~ json,
        let title: String = Keys.title <~~ json,
        let dataSetType: String = Keys.dataSetLink <~~ json,
        let dataSetLink: URL = Keys.dataSetLink <~~ json,
        let createdDate: Date = Keys.createdDate <~~ json else {
            return nil
        }
        
        self.id = id
        self.type = type
        self.title = title
        self.dataSetType = dataSetType
        self.dataSetLink = dataSetLink
        self.createdDate = createdDate
        lastModifiedDate = Keys.lastModifiedDate <~~ json ?? createdDate
        contributors = Keys.contributors <~~ json ?? []
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            Keys.id ~~> id,
            Keys.type ~~> type,
            Keys.title ~~> title,
            Keys.dataSetType ~~> dataSetType,
            Keys.dataSetLink ~~> dataSetLink,
            Keys.createdDate ~~> createdDate,
            Keys.lastModifiedDate ~~> lastModifiedDate,
            Keys.contributors ~~> contributors
        ])
    }
}
