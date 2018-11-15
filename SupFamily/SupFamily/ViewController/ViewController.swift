//
//  ViewController.swift
//  SupFamily
//
//  Created by Supinfo on 13/11/2018.
//  Copyright © 2018 Supinfo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var labelLogin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getLogin(){
        let postLogin = "action=login&username=\(String(describing: loginField.text!))&password=\(String(describing: passwordField.text!))"
        
        guard let responseLogin = apiRequest(toPost: postLogin) else {
            labelLogin.text="Connection impossible echec requete"
            return
        }
        
        if(!login(jsonR: responseLogin)){
            labelLogin.text="Connection impossible cause requete retour"
        } else {
            labelLogin.text="connection done"
        }
    }

}

