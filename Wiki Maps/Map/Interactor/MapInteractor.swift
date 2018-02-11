//
//  MapInteractor.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

final class MapInteractor {
    
    var viewModel = MapViewModel()
    weak var presenter: MapViewcontrollerInput?
    
    init(presenter: MapViewcontrollerInput) {
        self.presenter = presenter
    }
}


// MARK: View Controller Output

extension MapInteractor: MapViewControllerOutput {
    
    func fetchMapItems(withRequest request: FetchMapItems.Request) {
        // TODO: Add categories to query
        let request = GetItemsWorker.Request(geobox: request.geobox)
        GetItemsWorker.getItems(withRequest: request) { response in
            switch response {
            case .success(let items):
                let mapItems = items.flatMap(MapItem.init)
                let response = FetchMapItems.Response.success(mapItems: mapItems)
                self.presenter?.didReceiveMapItems(response: response)
            case .error(let error):
                let response = FetchMapItems.Response.error(error: error)
                self.presenter?.didReceiveMapItems(response: response)
                break
            }
        }
    }
    
    func updateMapItem(withRequest request: UpdateMapItem.Request) {
        // TODO
    }
}
