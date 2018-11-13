//: Playground - noun: a place where people can play

import Foundation

let url = "http://supinfo.steve-colinet.fr/supfamily/"

let request = NSMutableURLRequest(url: URL(string: url)!)
request.httpMethod = "POST"

let postString = "action=login&username=admin&password=admin"
request.httpBody = postString.data(using: String.Encoding.utf8)

let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) {data, response, error in
    if (error != nil) {
        print(error!.localizedDescription) // On indique dans la console ou est le problème dans la requête
    }
    let responseAPI = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
    print("responseString = \(responseAPI)") // Affiche dans la console la réponse de l'API
    if error == nil {
        // Ce que vous voulez faire.
    }
}
requestAPI.resume()

sleep(1)
