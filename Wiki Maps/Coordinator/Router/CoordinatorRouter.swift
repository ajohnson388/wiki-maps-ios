//
//  CoordinatorRouter.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

final class CoordinatorRouter {
    
    weak var viewController: CoordinatorViewController!
    
    init(viewController: CoordinatorViewController) {
        self.viewController = viewController
    }
}

extension CoordinatorRouter: CoordinatorRouterInput {
    
}
