//
//  MemberTableViewController.swift
//  SupFamily
//
//  Created by Supinfo on 15/11/2018.
//  Copyright © 2018 Supinfo. All rights reserved.
//

import UIKit

class MemberTableViewController : UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    var family: Family? {
//        let postList = "action=list&username=admin&password=admin"
//        
//        guard let responseList = apiRequest(toPost: postList) else {
//            return nil
//        }
//        
//        return list(jsonR: responseList)
//    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        guard let family = family else{
//            return nil
//        }
//        
//        return family.name
//        
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let family = family else{
//            return 0
//        }
//        
//        return family.members!.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
//        
//        cell.textLabel?.text = family!.members![indexPath.row].lasName
//        return cell
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let indexPath = tableView.indexPathForSelectedRow else {return}
//        
//        segue.destination.navigationItem.title = family!.members![indexPath.row].lasName
//    }
}
