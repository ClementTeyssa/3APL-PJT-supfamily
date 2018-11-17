//
//  MemberTableViewController.swift
//  SupFamily
//
//  Created by Supinfo on 15/11/2018.
//  Copyright © 2018 Supinfo. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell{
    @IBOutlet weak var memberInfo: UILabel!
}


class MemberTableViewController : UITableViewController{
    
    var family: Family?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let postList = "action=list&username=admin&password=admin"
        
        guard let responseList = apiRequest(toPost: postList) else {
            return
        }
        
        family = list(jsonR: responseList)
    }
    
    //Nombre de section dans la TableList
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Noms des sections
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let family = family else{
            return nil
        }
        
        return family.name
    }
    
    //Nombre de cellulde dans chaque section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let family = family else{
            return 0
        }
        
        return family.members!.count
    }
    
    //Implementation d'une cellule
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! MemberTableViewCell
        
        let member = family!.members![indexPath.row]
        let str = "#\(member.userId) \(member.lasName) \(member.firstName)"
        cell.memberInfo?.text = str
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        
        segue.destination.navigationItem.title = family!.members![indexPath.row].lasName
    }
}
