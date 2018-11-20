//
//  ViewController.swift
//  SupFamily
//
//  Created by Supinfo on 13/11/2018.
//  Copyright © 2018 Supinfo. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For use when the app is open & in the background
        locationManager.requestAlwaysAuthorization()
        
        // For use when the app is open
        //locationManager.requestWhenInUseAuthorization()
        
        // If location services is enabled get the users location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
            locationManager.startUpdatingLocation()
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getLogin(_ sender: Any){
        let postLogin = "action=login&username=\(String(describing: loginField.text!))&password=\(String(describing: passwordField.text!))"

        guard let responseLogin = apiRequest(toPost: postLogin) else {
            labelLogin.text="Connection impossible"
            return
        }

        
        if(login(jsonR: responseLogin)==nil){
            labelLogin.text="Wrong Login / Password"
        } else {
            initDbTables(db: DataBaseSupFamily.db!)
            currentUser.currentUserId = responseLogin.user?.userId
            currentUser.currentFamilyId = responseLogin.family?.id
            insertUser(db: DataBaseSupFamily.db!, userId: (responseLogin.user?.userId)!, username: loginField.text!, password: passwordField.text!)
            performSegue(withIdentifier: "MembersList", sender: loginButton)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? UIButton {return}

        segue.destination.navigationItem.title = "SupFamily"
    }
    
        // Used to start getting the users location
        let locationManager = CLLocationManager()
        
        
        // Print out the location to the console
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                print(location.coordinate)
            }
        }
        
        // If we have been deined access give the user the option to change it
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if(status == CLAuthorizationStatus.denied) {
                showLocationDisabledPopUp()
            }
        }
        
        // Show the popup to the user if we have been deined access
        func showLocationDisabledPopUp() {
            let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                    message: "In order to deliver pizza we need your location",
                                                    preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                if let url = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            alertController.addAction(openAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
}

