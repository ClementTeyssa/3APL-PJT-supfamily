//: Playground - noun: a place where people can play

import Foundation

//    let url = "http://supinfo.steve-colinet.fr/supfamily/?action=login&username=admin&password=admin"
//
//let request = NSMutableURLRequest(url: URL(string: url)!)
//request.httpMethod = "GET"
//
//let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) {data, response, error in
//    if (error != nil) {
//        print(error!.localizedDescription) // On indique dans la console ou est le problème dans la requête
//    }
//    if let httpStatus = response as? HTTPURLResponse , httpStatus.statusCode != 200 {
//        print("statusCode devrait être de 200, mais il est de \(httpStatus.statusCode)")
//        print("réponse = \(response)") // On affiche dans la console si le serveur ne nous renvoit pas un code de 200 qui est le code normal
//    }
//
//    let responseAPI = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//    print("responseString = \(responseAPI)") // Affiche dans la console la réponse de l'API
//
//    if error == nil {
//        //
//    }
//}
//requestAPI.resume()








let url = "http://supinfo.steve-colinet.fr/supfamily/"

let request = NSMutableURLRequest(url: URL(string: url)!)
request.httpMethod = "POST"

let postString = "action=login&username=admin&password=admin"
request.httpBody = postString.data(using: String.Encoding.utf8)

let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) {data, response, error in
    if (error != nil) {
        print(error!.localizedDescription) // On indique dans la console ou est le problème dans la requête
    }
    if let httpStatus = response as? HTTPURLResponse , httpStatus.statusCode != 200 {
        print("statusCode devrait être de 200, mais il est de \(httpStatus.statusCode)")
        print("réponse = \(response)") // On affiche dans la console si le serveur ne nous renvoit pas un code de 200 qui est le code normal
    }
    
    let responseAPI = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
    print("responseString = \(responseAPI)") // Affiche dans la console la réponse de l'API
    
    if error == nil {
        // Ce que vous voulez faire.
    }
}
requestAPI.resume()








sleep(1)
