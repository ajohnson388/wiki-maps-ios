//
//  CoordinatorConfigurator.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

final class CoordinatorConfigurator: CoordinatorConfiguratorType {

    func configure(viewController: CoordinatorViewController) {
        viewController.interactor
            = CoordinatorInteractor(presenter: viewController)
        viewController.router
            = CoordinatorRouter(viewController: viewController)
    }
}
