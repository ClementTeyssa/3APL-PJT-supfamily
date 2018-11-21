//
//  ViewController.swift
//  SupFamily
//
//  Created by Supinfo on 13/11/2018.
//  Copyright © 2018 Supinfo. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    var locationManager: CLLocationManager!
    var ApiRest = ApiRESTController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getLogin(_ sender: Any){
        
        if( ApiRest.login(usernameF: loginField.text!, passwordF: passwordField.text!) ){
            //_ = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(updateCurrentPosition), userInfo: nil, repeats: true)
            performSegue(withIdentifier: "MembersList", sender: loginButton)
        } else {
            labelLogin.text = "Wrong username and/or password"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? UIButton {return}

        segue.destination.navigationItem.title = "SupFamily"
    }
    
//    @objc func updateCurrentPosition(){
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.startUpdatingLocation()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations: [CLLocation]){
//        let location = didUpdateLocations[0]
//
//        manager.stopUpdatingLocation()
//        let postUpdateLocation = "action=update&username=admin&password=admin&latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)"
//
//        guard let responseUpdateLocation = apiRequest(toPost: postUpdateLocation) else {
//            labelLogin.text="Update Location impossible"
//            return
//        }
//
//        if(!updateLocation(jsonR: responseUpdateLocation)){
//            print("Can't update location in the APIRest")
//        } else {
//            updateLocation(db: DataBaseSupFamily.db!, userId: currentUser.currentUserId!, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        }
//
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
//    {
//        print("Error \(error)")
//    }
}

