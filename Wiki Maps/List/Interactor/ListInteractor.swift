//
//  ListInteractor.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

final class ListInteractor {
    
    var viewModel: ListViewModel = ListViewModel()
    weak var presenter: ListViewControllerInput!
    
    init(presenter: ListViewControllerInput) {
        self.presenter = presenter
    }
}


// MARK: List View Controller Output

extension ListInteractor: ListViewControllerOutput {
    
    
}
