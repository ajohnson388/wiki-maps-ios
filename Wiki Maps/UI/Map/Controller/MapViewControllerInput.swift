//
//  MapViewControllerInput.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

protocol MapViewcontrollerInput: class {
    
    func didReceiveMapItems(response: FetchMapItems.Response)
    func didUpdateMapItem(withResponse response: UpdateMapItem.Response)
}
