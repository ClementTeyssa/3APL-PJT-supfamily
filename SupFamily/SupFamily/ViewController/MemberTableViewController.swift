//
//  MemberTableViewController.swift
//  SupFamily
//
//  Created by Supinfo on 15/11/2018.
//  Copyright © 2018 Supinfo. All rights reserved.
//

import UIKit


protocol MemberTableViewCellDelegate: class {
    func memberTableViewCellRemove(_ sender: MemberTableViewCell)
}

class MemberTableViewCell: UITableViewCell{
    @IBOutlet weak var removeMemberButton: UIButton!
    @IBOutlet weak var memberInfo: UILabel!
    
    weak var delegate: MemberTableViewCellDelegate?
    
    @IBAction func removeMember(_ sender: UIButton){
        delegate?.memberTableViewCellRemove(self)
    }
}

class MemberTableViewController : UITableViewController, MemberTableViewCellDelegate{
    //DB
    var db: OpaquePointer?

    //Pull to Refresh
    lazy var refreshC : UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(MemberTableViewController.pullToRefresh(_:)), for: UIControlEvents.valueChanged)
        
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    
    var family: Family?
    
    //Actualise la list
    @objc func pullToRefresh(_ RefreshControl: UIRefreshControl){
        //Update la base de donnée puis update la famille
        self.tableView.reloadData()
        
        refreshC.endRefreshing()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let postList = "action=list&username=admin&password=admin"
        
        guard let responseList = apiRequest(toPost: postList) else {
            return
        }

        family = list(jsonR: responseList)
        self.tableView.addSubview(self.refreshC)
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
        cell.delegate = self
        
        let member = family!.members![indexPath.row]
        let str = "#\(member.userId) \(member.lasName) \(member.firstName)"
        cell.memberInfo?.text = str
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        
        segue.destination.navigationItem.title = family!.members![indexPath.row].lasName
    }
    
    func memberTableViewCellRemove(_ sender: MemberTableViewCell) {
        //supprimer de la base et de l'api dans le cas ou la requete HTTP reussie
        guard let removedMember = tableView.indexPath(for: sender) else {return}

        let postRemove = "action=remove&username=admin&password=admin&memberId=\(family!.members![removedMember.row].userId)"
        
        guard let responseRemove = apiRequest(toPost: postRemove) else {
            //afficher un mesage erreur pas de reponse de l'api
            return
        }
        
        if(!removeMember(jsonR: responseRemove)){
            print("succes false")
        } else {
            family?.members?.remove(at: removedMember.row)
            tableView.deleteRows(at: [removedMember], with: .automatic)
        }
    }
}
