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

func apiRequest(toPost:String) -> JSONRequest?{
    let url = "http://supinfo.steve-colinet.fr/supfamily/"
    let request = NSMutableURLRequest(url: URL(string: url)!)
    request.httpMethod = "POST"
    request.httpBody = toPost.data(using: String.Encoding.utf8)
    var resJSON: JSONRequest? = nil
    
    let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) {data, response, error in
        
        guard let data = data else {
            print("Error: Request hasn't return data")
            print(error)
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

func login(jsonR: JSONRequest) -> Bool {
    if jsonR.success != nil {
        print("Login impossible")
        return false
    }
    
    //add in BDD
    print(jsonR.family!.name)
    return true
}

func list(jsonR: JSONRequest) -> Family? {
    if jsonR.success != nil {
        print("Get List impossible")
        return nil
    }
    
    print(jsonR.family!.members![0].lasName)
    //add in BDD
    return jsonR.family
}

func removeMember(jsonR: JSONRequest) -> Bool{
    return jsonR.success!
}
