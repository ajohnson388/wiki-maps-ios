//
//  Location.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/17/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import Gloss

struct Location {
    var latitiude: Double?
    var longitude: Double?
}


// MARK: - Keys

extension Location {
    
    struct Keys {
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
}


// MARK: - Glossy

extension Location: Glossy {
    
    init?(json: JSON) {
        latitiude = Keys.latitude <~~ json
        longitude = Keys.longitude <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            Keys.latitude ~~> latitiude,
            Keys.longitude ~~> longitude
        ])
    }
}
