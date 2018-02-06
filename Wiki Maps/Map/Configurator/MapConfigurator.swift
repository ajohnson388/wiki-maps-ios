//
//  MapConfigurator.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

final class MapConfigurator: MapConfiguratorType {
    
    func configure(viewController: MapViewController) {
        viewController.interactor = MapInteractor(presenter: viewController)
        viewController.router = MapRouter(viewController: viewController)
    }
}
