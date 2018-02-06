//
//  CoordinatorViewController.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import UIKit

final class CoordinatorViewController: UIViewController {
    
    static var configurator: CoordinatorConfiguratorType
        = CoordinatorConfigurator()
    
    var interactor: CoordinatorViewControllerOuput!
    var router: CoordinatorRouterInput!
    
    let contentViewController: UIViewController
    let waterfallViewController: UIViewController
    
    lazy var pulleyHandler = PulleyHandler(coordinator: self)
    
    var waterfallHeightConstraint: NSLayoutConstraint?
    
    private let listWidth: CGFloat = 320
    
    init(contentViewController: UIViewController,
         waterfallViewController: UIViewController) {
        self.contentViewController = contentViewController
        self.waterfallViewController = waterfallViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure architecture components
        CoordinatorViewController.configurator
            .configure(viewController: self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addContentView()
        addWaterfallView()
        pulleyHandler.addGesture()
        layoutViews()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        layoutViews()
    }
}


// MARK: View Setup
// TODO: This should go in another arch component, e.g. LayoutManager

extension CoordinatorViewController {
    
    func addContentView() {
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(contentViewController)
        view.addSubview(contentViewController.view)
    }
    
    func addWaterfallView() {
        waterfallViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(waterfallViewController)
        view.addSubview(waterfallViewController.view)
    }
    
    func layoutViews() {
        
        // Apply autolayout
        let deviceType = UIDevice.current.userInterfaceIdiom
        switch deviceType {
        case .pad: layoutForTablet()
        case .phone: layoutForPhone()
        default: fatalError("Unsupported device type: \(deviceType.rawValue)")
        }
    }
    
    func layoutForPhone() {
        // Set the content view to be the entire screen
        contentViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Add the waterfall view as a pulley bar at the bottom
        // The pulley bar should be part of the coordinator and
        // not the content view
        waterfallViewController.view.leadingAnchor.constraint(equalTo: contentViewController.view.leadingAnchor).isActive = true
        waterfallViewController.view.trailingAnchor.constraint(equalTo: contentViewController.view.trailingAnchor).isActive = true
        
//        waterfallViewController.view.widthAnchor.constraint(lessThanOrEqualToConstant: 320).isActive = true
//        waterfallViewController.view.leadingAnchor.constraint(greaterThanOrEqualTo: contentViewController.view.leadingAnchor).isActive = true
//        waterfallViewController.view.trailingAnchor.constraint(lessThanOrEqualTo: contentViewController.view.trailingAnchor).isActive = true
        
        waterfallHeightConstraint = waterfallViewController.view.heightAnchor.constraint(equalTo: contentViewController.view.heightAnchor, constant: 44 - contentViewController.view.frame.size.height)
        waterfallHeightConstraint?.isActive = true
        waterfallViewController.view.bottomAnchor.constraint(equalTo: contentViewController.view.bottomAnchor).isActive = true
    }
    
    func layoutForTablet() {
        // Lock the waterfall view to the leading edge of the screen and fix the width
        waterfallViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        waterfallViewController.view.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: listWidth).isActive = true
        waterfallViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        waterfallViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        
        // Set the content view to fill the rest of the screen
        contentViewController.view.leadingAnchor.constraint(equalTo: waterfallViewController.view.trailingAnchor).isActive = true
        contentViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}


// MARK: Presenter Callbacks

extension CoordinatorViewController: CoordinatorViewControllerInput {
    
}
