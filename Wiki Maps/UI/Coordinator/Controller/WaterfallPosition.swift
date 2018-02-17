//
//  WaterfallPosition.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/3/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

enum DrawerPosition {
    case closed
    case partial
    case opened
}


// MARK: Adjacent Positions

extension DrawerPosition {
    
    static let orderedPositions = [DrawerPosition.closed, .partial, .opened]
    
    var nextPosition: DrawerPosition? {
        switch self {
        case .closed: return .partial
        case .partial: return .opened
        case .opened: return nil
        }
    }
    
    var previousPosition: DrawerPosition? {
        switch self {
        case .closed: return nil
        case .partial: return .closed
        case .opened: return .partial
        }
    }
}
