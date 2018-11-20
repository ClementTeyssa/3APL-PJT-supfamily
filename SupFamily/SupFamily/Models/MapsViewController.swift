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
        
        var family: Family?
        let APIGoogleMapsKey = "AIzaSyDNcD-45wpSyRKHCqoAXPNwN7isZLrHT_8"
        
        let postPosition = "action=getPosition&username=admin&password=admin"
        
        if let responsePosition = apiRequest(toPost: postPosition){
            family = responsePosition.family
        }
        
        GMSServices.provideAPIKey(APIGoogleMapsKey)
        
        for member in (family?.members!)!{
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: member.latitude!, longitude: member.longitude!)
            marker.title = member.firstName
            marker.snippet = member.lasName
            marker.map = mapView
            
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: (family?.members![0].latitude)!, longitude: (family?.members![0].longitude)!, zoom: 10)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
    }
}
