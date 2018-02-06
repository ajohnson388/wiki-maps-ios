//
//  ListConfigurator.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

final class ListConfigurator: ListConfiguratorType {
    
    func configure(viewController: ListViewController) {
        viewController.interactor = ListInteractor(presenter: viewController)
        viewController.router = ListRouter(viewController: viewController)
    }
}
