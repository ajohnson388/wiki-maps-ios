//
//  MapRouter.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

final class MapRouter {
    
    weak var viewController: MapViewController!
    
    init(viewController: MapViewController) {
        self.viewController = viewController
    }
}


// MARK: Router Input

extension MapRouter: MapRouterInput {
    
    func openMapItem(withId id: String) {
        // TODO: Navigate to wiki page / safari view controller
    }
    
    func displayError(withMessage message: String) {
        // TODO: Implement
    }
}
