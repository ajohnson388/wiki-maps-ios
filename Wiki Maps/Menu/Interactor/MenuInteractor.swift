//
//  MenuInteractor.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/5/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

final class MenuInteractor {
    
    weak var presenter: MenuViewControllerInput!
    
    init(presenter: MenuViewControllerInput) {
        self.presenter = presenter
    }
}


// MARK: Menu View Controller Output

extension MenuInteractor: MenuViewControllerOutput {
    
    
}
