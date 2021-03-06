//
//  ListViewControllerOutput.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

protocol ListViewControllerOutput: class {
    var viewModel: ListViewModel { get }
    
    func fetchListItems(withRequest request: FetchListItems.Request)
}
