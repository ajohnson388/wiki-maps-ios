//
//  ListViewController.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import UIKit

final class ListViewController: UITableViewController {
    
    // MARK: Properties
    
    static var configurator: ListConfiguratorType = ListConfigurator()
    
    var interactor: ListViewControllerOutput!
    var router: ListRouterInput!
    
    
    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListViewController.configurator.configure(viewController: self)
    }
    
    
    // MARK: UITableView DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20//interactor.viewModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = "map_item_cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId)
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: reuseId)
        //let item = interactor.viewModel.items[indexPath.row]
        cell.accessoryType = UIDevice.isPad ? .detailButton : .disclosureIndicator
        cell.textLabel?.text = "TEST"//item.title
        cell.detailTextLabel?.text = "FSFDS"//item.subtitle
        cell.selectionStyle = .gray
        return cell
    }
    
    
    // MARK: UITableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !UIDevice.isPad {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}


// MARK: List View Controller Input

extension ListViewController: ListViewControllerInput {
    
}
