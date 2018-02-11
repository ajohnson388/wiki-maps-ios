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
    
    
    /**
        The list view is driven by the data displayed by the map. This
        data should be shared across the two views via a listener.
     */
    func setupMapDataListener() {
        
    }
}


// MARK: List View Controller Output

extension ListInteractor: ListViewControllerOutput {
    
    func fetchListItems(withRequest request: FetchListItems.Request) {
        // TODO: This will be used for searching otherwise, waterfall just
        // displays whats visibile
    }
}
