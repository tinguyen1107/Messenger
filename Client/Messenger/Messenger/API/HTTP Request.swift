//
//  HTTP Request.swift
//  Messenger
//
//  Created by Trọng Tín on 26/07/2021.
//

import Foundation
import Alamofire

class User: Codable {
    internal init(email: String? = "", password: String? = "", _id: String? = nil, fullname: String? = nil) {
        self.email = email
        self.password = password
        self._id = _id
        self.fullname = fullname
    }
    
    var email: String?
    var password: String?
    var _id: String?
    var fullname: String?
}

//class LocalAlamofire {
class HttpRequest {
    func login (user: User, complete: @escaping (Int, User?)->()) {
        let url = BaseURL + "/login"
        AF.request(url, method: .post, parameters: user, encoder: URLEncodedFormParameterEncoder(destination: .httpBody))
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                switch response.result {
                case .success(let JSON):
                    print("Success with JSON: \(JSON)")
                    if let data = JSON as? Dictionary<String, Any> {
                        print("\nData: \(data)")
                        let result = data["result"] as! Int
                        if result != 0 {complete(result, nil)}
                        else {
                            let final = try! JSONSerialization.data(withJSONObject: data["details"]!)
                            let user = try! JSONDecoder().decode(User.self, from: final)
                            complete(result, user)
                        }
                    }
                case .failure(let error):
                    debugPrint("Request failed with error: \(error)")
                }
            }
    }
    
    func register (user: User, complete: @escaping (Int, User?)->()) {
        let url = BaseURL + "/register"
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    print("Success with JSON: \(JSON)")
                    if let data = JSON as? Dictionary<String, Any> {
                        print("\nData: \(data)")
                        let result = data["result"] as! Int
                        if result != 0 {complete(result, nil)}
                        else {
                            let final = try! JSONSerialization.data(withJSONObject: data["details"]!)
                            let user = try! JSONDecoder().decode(User.self, from: final)
                            complete(result, user)
                        }
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
    }
}
// hello
//    func login (user: User, complete: @escaping ()->()) {
//        let url = BaseURL + "/login"
//
//        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).response { response in
//
//        }
//    }
//
//    func register (user: User, complete: @escaping (Void)->()) {
//        let url = BaseURL + "/register"
//
//        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).response { response in
//            print("hello")
//            print(response)
//            debugPrint(response)
//        }
//    }
//
//
//    func getUser () {
//        let url = BaseURL + "/"
//        AF.request(url)
//            .validate(statusCode: 200..<300)
//            .responseJSON { response in
//            }
//    }
//
//    func handleAF () {
//        AF.request("http://localhost:7000/messages")
//            .validate(statusCode: 200..<300)
//            .responseJSON { response in
//                switch response.result {
//                case .success(let JSON):
//                    print("Success with JSON: \(JSON)")
//
//                    let response = JSON as! NSDictionary
//
////                    self.statusSocket.text = response.object(forKey: "message") as? String
//
//                case .failure(let error):
//                    print("Request failed with error: \(error)")
//                }
//            }
//    }

//class User: Encodable {
//    var name: String?
//    var id: String
//    var password: String
//
//    internal init(name: String? = "default for login", id: String, password: String) {
//        self.name = name
//        self.id = id
//        self.password = password
//    }
//}
