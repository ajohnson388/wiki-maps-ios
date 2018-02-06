//
//  MapInteractor.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

final class MapInteractor {
    
    weak var presenter: MapViewcontrollerInput!
    
    init(presenter: MapViewcontrollerInput) {
        self.presenter = presenter
    }
}


// MARK: View Controller Output

extension MapInteractor: MapViewControllerOutput {
    
    func fetchMapItems(withRequest request: FetchMapItems.Request) {
        // TODO: Fetch items from the local db based on the
        // request parameters
    }
}
