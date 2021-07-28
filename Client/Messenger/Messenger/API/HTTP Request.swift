//
//  HTTP Request.swift
//  Messenger
//
//  Created by Trọng Tín on 26/07/2021.
//

import Foundation
import Alamofire

class LocalAlamofire {
    
    func login (user: User, complete: @escaping (Void)->()) {
        let url = BaseURL + "/login"
        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).response { response in
            
        }
    }
    
    func register (user: User, complete: @escaping (Void)->()) {
        let url = BaseURL + "/register"
        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).response { response in
            print("hello")
            print(response)
            debugPrint(response)
        }
    }
    
    
    func getUser () {
        let url = BaseURL + "/"
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
            }
    }
    
    func handleAF () {
        AF.request("http://localhost:7000/messages")
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    print("Success with JSON: \(JSON)")

                    let response = JSON as! NSDictionary
                    
//                    self.statusSocket.text = response.object(forKey: "message") as? String

                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
    }
}

class User: Encodable {
    var name: String?
    var id: String
    var password: String
    
    internal init(name: String? = "default for login", id: String, password: String) {
        self.name = name
        self.id = id
        self.password = password
    }
}
