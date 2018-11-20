//
//  MapsViewController.swift
//  SupFamily
//
//  Created by Supinfo on 20/11/2018.
//  Copyright © 2018 Supinfo. All rights reserved.
//

import UIKit
import GoogleMaps

class MapsViewController: UIViewController{
    
    private let APIGoogleMapsKey = "AIzaSyDNcD-45wpSyRKHCqoAXPNwN7isZLrHT_8"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey(APIGoogleMapsKey)
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.62, longitude: -122.37, zoom: 10)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
    }
}
