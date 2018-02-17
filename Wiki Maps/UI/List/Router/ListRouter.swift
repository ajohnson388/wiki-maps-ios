//
//  ListRouter.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

final class ListRouter {
    
    weak var viewController: ListViewController!
    
    init(viewController: ListViewController) {
        self.viewController = viewController
    }
}


// MARK: List Router Input

extension ListRouter: ListRouterInput {
    
}
