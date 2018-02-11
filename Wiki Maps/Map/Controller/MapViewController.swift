//
//  MapViewController.swift
//  Wiki Maps
//
//  Created by Andrew Johnson on 2/2/18.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import UIKit
import Mapbox

final class MapViewController: UIViewController {
    
    static var configurator: MapConfiguratorType = MapConfigurator()
    
    var interactor: MapViewControllerOutput!
    var router: MapRouterInput!
    
    lazy var mapView: MGLMapView = MGLMapView(frame: view.bounds)
    
    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapViewController.configurator.configure(viewController: self)
        setupMapView()
    }
}


// MARK: View Setup

extension MapViewController {
    
    func setupViews() {
        setupMapView()
    }
    
    func setupMapView() {
        configureMapView()
        layoutMapView()
    }
    
    func layoutMapView() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    func configureMapView() {
        mapView.delegate = self
    }
}


// MARK: Map Delegate

extension MapViewController: MGLMapViewDelegate {
    
}


// MARK: View Controller Input

extension MapViewController: MapViewcontrollerInput {
    
    func didReceiveMapItems(response: FetchMapItems.Response) {
        // TODO: Implement
        switch response {
        case .success(let mapItems):
            break
        case .error(let error):
            break
        }
    }
    
    func didUpdateMapItem(withResponse response: UpdateMapItem.Response) {
        // TODO: Implement
        switch response {
        case .success:
            break
        case .error(let error):
            break
        }
    }
}
