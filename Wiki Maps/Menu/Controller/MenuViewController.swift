//
//  MenuViewController.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/5/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import UIKit

final class MenuViewController: UIViewController {
    
    static var configurator: MenuConfiguratorType = MenuConfigurator()
    
    var router: MenuRouterInput!
    var interactor: MenuViewControllerOutput!
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MenuViewController.configurator.configure(viewController: self)
    }
}


// MARK: Menu View Controller Input

extension MenuViewController: MenuViewControllerInput {
    
    
}
