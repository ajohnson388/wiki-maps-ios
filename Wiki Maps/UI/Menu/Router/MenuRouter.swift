//
//  MenuRouter.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/5/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

final class MenuRouter {
    
    weak var viewController: MenuViewController!
    
    init(viewController: MenuViewController) {
        self.viewController = viewController
    }
}


// MARK: Router Input

extension MenuRouter: MenuRouterInput {
    
}
