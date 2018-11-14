import Foundation

func apiRequest(toPost:String) -> Data{
    let url = "http://supinfo.steve-colinet.fr/supfamily/"
    let request = NSMutableURLRequest(url: URL(string: url)!)
    request.httpMethod = "POST"
    request.httpBody = toPost.data(using: String.Encoding.utf8)
    
    let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) {data, response, error in
        if error == nil {
            return data!
        } else {
            return nil
        }
    }
    requestAPI.resume()
    sleep(1)
}

let postString = "action=login&username=admin&password=admin"
let response = apiRequest(toPost: postString)
let responseString = NSString(data: response, encoding: String.Encoding.utf8.rawValue)
print(responseString)
