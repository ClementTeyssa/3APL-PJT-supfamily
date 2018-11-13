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

print("okok")

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
    
    enum CodingKeys:String,CodingKey{
        case id
        case name
        case members
    }
}

struct Login: Decodable{
    let family: Family
    let user: User
}

print("test")

let url = URL(string: "http://supinfo.steve-colinet.fr/supfamily/?action=login&username=admin&password=admin")

let task = URLSession.shared.dataTask(with: url!) { data, response, error in
    guard error == nil else {
        print(error!)
        return
    }
    guard let data = data else {
        print("Data is empty")
        return
    }
    
    print("ok")
 
    guard let login = try? JSONDecoder().decode(Login.self, from: data) else {
        print("Error: Couldn't decode data into Blog")
        return
    }
    
    print(login.user.userId)
    
    /*print("members:")
    for member in family.members {
        print("- \(member.firstName)")
    }*/
    
    
}
task.resume()




