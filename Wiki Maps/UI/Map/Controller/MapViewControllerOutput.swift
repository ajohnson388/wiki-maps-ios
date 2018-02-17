//
//  MapViewControllerOutput.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

protocol MapViewControllerOutput: class {
    var viewModel: MapViewModel { get }
    func fetchMapItems(withRequest request: FetchMapItems.Request)
    func updateMapItem(withRequest request: UpdateMapItem.Request)
}
