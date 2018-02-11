//
//  MenuConfigurator.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/5/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

final class MenuConfigurator: MenuConfiguratorType {
    
    func configure(viewController: MenuViewController) {
        viewController.router = MenuRouter(viewController: viewController)
        viewController.interactor = MenuInteractor(presenter: viewController)
    }
}
