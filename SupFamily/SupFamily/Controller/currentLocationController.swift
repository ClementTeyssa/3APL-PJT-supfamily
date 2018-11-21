//
//  currentLocationController.swift
//  SupFamily
//
//  Created by Supinfo on 21/11/2018.
//  Copyright © 2018 Supinfo. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentLocationController: NSObject, CLLocationManagerDelegate{

    var locationManager: CLLocationManager!
    
    func updateCurrentPosition(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations: [CLLocation]){
        let location = didUpdateLocations[0]
        
        manager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}
