//: Playground - noun: a place where people can play
//'{
//    "family": {
//        "id":1,
//        "name": "myFamily"
//    },
//    "user": {
//        "userId":15,
//        "lasName": "COLINET",
//        "firstName":"Steve"
//    }
//}

import PlaygroundSupport
import Foundation
PlaygroundPage.current.needsIndefiniteExecution = true


struct User: Decodable{
    let userId: Int
    let lasName: String
    let firstName: String
    let latitude: Double?
    let longitude: Double?
}

struct Family: Decodable{
    let id: Int
    let name: String
    let members: [User]?
}

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

let postLogin = "action=login&username=ad&password=adm"
let responseLogin = apiRequest(toPost: postLogin)
let postList = "action=list&username=admin&password=admin"
let responseList = apiRequest(toPost: postList)

let postLogout = "action=logout&username=admi&password=admin"
let responseLogout = apiRequest(toPost: postLogout)

func login(jsonR: JSONRequest) -> Bool {
    if jsonR.success != nil {
        print("Login impossible")
        return false
    }
    
    //add in BDD
    print(jsonR.family!.name)
    return true
}

func list(jsonR: JSONRequest) -> Bool {
    if jsonR.success != nil {
        print("Get List impossible")
        return false
    }

    print(jsonR.family!.id)
    //add in BDD
    return true
}

func position(jsonR: JSONRequest) -> Bool{
    if jsonR.success != nil {
        print("Get List impossible")
        return false
    }
    
    return true
}

func logout(jsonR: JSONRequest) -> Bool{
    return jsonR.success!
}



func removeMember(jsonR: JSONRequest) -> Bool{
    return jsonR.success!
}

func updatePosition(jsonR: JSONRequest) -> Bool{
    return true
}

login(jsonR: responseLogin!)
list(jsonR: responseLogin!)
if(logout(jsonR: responseLogout!)){
    print("Logout")
}



