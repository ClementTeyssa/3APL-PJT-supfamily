//
//  ApiRESTController.swift
//  SupFamily
//
//  Created by Supinfo on 15/11/2018.
//  Copyright © 2018 Supinfo. All rights reserved.
//

import Foundation


struct JSONRequest: Decodable{
    let family: Family?
    let user: User?
    let success: Bool?
}



class ApiRESTController {
    static var currentUserId: Int = 0
    static var currentFamilyId: Int = 0
    
    func apiRequest(toPost:String) -> JSONRequest?{
        let url = "http://supinfo.steve-colinet.fr/supfamily/"
        let request = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = toPost.data(using: String.Encoding.utf8)
        var resJSON: JSONRequest? = nil
        
        let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) {data, response, error in
            
            guard let data = data else {
                print("Error: Request hasn't return data")
                return
            }
            
            //decodage
            guard let json = try? JSONDecoder().decode(JSONRequest.self, from: data) else {
                print("Error: Couldn't decode data")
                return
            }
            
            resJSON=json
        }
        
        requestAPI.resume()
        sleep(1)
        return resJSON
    }
    
    func login(usernameF: String, passwordF: String) -> Bool{
        let postLogin = "action=login&username=\(usernameF)&password=\(passwordF)"

        guard let responseLogin = apiRequest(toPost: postLogin) else {
            print("Login APIRest failed ")
            return false
        }
        
        if responseLogin.success != nil {
            print("Wrong Login / password")
            return false
        }
        
        initDbTables(db: DataBaseSupFamily.db!)
        ApiRESTController.currentUserId = (responseLogin.user?.userId)!
        ApiRESTController.currentFamilyId = (responseLogin.family?.id)!
        insertUser(db: DataBaseSupFamily.db!, userId: (responseLogin.user?.userId)!, username: usernameF, password: passwordF)
        insertFamily(db: DataBaseSupFamily.db!, family: responseLogin.family!)
        insertMember(db: DataBaseSupFamily.db!, member: responseLogin.user!, familyId: (responseLogin.family?.id)!)
        print("Login succes")
        return true
    }
    
    
    func list() -> Family? {
        let user = selectUser(db: DataBaseSupFamily.db!, id: ApiRESTController.currentUserId)
        let postList = "action=list&username=\(user.username!)&password=\(user.password!)"
        print(postList)
        guard let responseList = apiRequest(toPost: postList) else {
            print("Get List impossible")
            return nil
        }
        
        guard let family = responseList.family else {
            print("Request success false")
            return nil
        }
        
        updateList(db: DataBaseSupFamily.db!, list: family)
        
        return family
    }
    
    func removeMember(jsonR: JSONRequest) -> Bool{
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
        
        return jsonR.success!
    }
    
    func addMemberr(jsonR: JSONRequest) -> Bool{
        //add in DB
        return jsonR.success!
    }
    
    func updateLocation(jsonR: JSONRequest) -> Bool{
        return jsonR.success!
    }
    
}



