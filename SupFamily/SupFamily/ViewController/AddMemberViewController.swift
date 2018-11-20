//
//  AddMemberViewController.swift
//  SupFamily
//
//  Created by Supinfo on 20/11/2018.
//  Copyright © 2018 Supinfo. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController {
    @IBOutlet weak var addMemberButton: UIButton!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var resAddLabel: UILabel!
    
    @IBAction func addMember(_ sender: Any){
        let postAdd = "action=add&username=admin&password=admin&memberCode=1"
        
        guard let responseAdd = apiRequest(toPost: postAdd) else {
            resAddLabel.text="Connection impossible"
            return
        }
        
        if(!addMemberr(jsonR: responseAdd)){
            resAddLabel.text="Add impossible"
        } else {
            //insertMember(db: DataBaseSupFamily, member: User, familyId: currentUser.currentFamilyId)
            resAddLabel.text="Add done"
        }
    }
    
}
