//
//  MapRouterInput.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

protocol MapRouterInput: class {

    func openMapItem(withId id: String)
    func displayError(withMessage message: String)
}
