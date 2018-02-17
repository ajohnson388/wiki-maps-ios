//
//  Rectangle.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct Rectangle {
    var left: Double
    var right: Double
    var top: Double
    var bottom: Double
}


extension Rectangle {
    
    func containsPoint(x: Double, y: Double) -> Bool {
        return left <= x && x <= right && bottom <= y && y <= top
    }
}
