//
//  CoordinatorInteractor.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

final class CoordinatorInteractor {
    
    weak var presenter: CoordinatorViewControllerInput!
    
    init(presenter: CoordinatorViewControllerInput) {
        self.presenter = presenter
    }
}

extension CoordinatorInteractor: CoordinatorViewControllerOuput {
    
}
