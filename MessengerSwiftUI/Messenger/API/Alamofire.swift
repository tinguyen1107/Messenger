//
//  Alamofire.swift
//  Messenger
//
//  Created by Trọng Tín on 10/08/2021.
//

import Foundation
import Alamofire
import SwiftUI

let BaseURL = "http://localhost:7000"

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct Alamofire {
    func login_register (state: String, user: User, complete: @escaping (Int, User?)->()) {
        let url = BaseURL + "/" + state
        
        AF.request(url, method: .post, parameters: user, encoder: URLEncodedFormParameterEncoder(destination: .httpBody))
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
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
    
    func getAllUsersWithConservation (fromId: String, complete: @escaping (Int, [User]?)->()) {
        let url = BaseURL + "/conservation/get_all_friends"
        let params: Parameters = [ "id": fromId ]
        
        AF.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    if let data = JSON as? Dictionary<String, Any> {
                        print("\nData: \(data)")
                        let result = data["result"] as! Int
                        if result != 0 {complete(result, nil)}
                        else {
                            let final = try! JSONSerialization.data(withJSONObject: data["details"]!)
                            let listUser = try! JSONDecoder().decode([User].self, from: final)
                            complete(result, listUser)
                        }
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
    }
    
    func getAllUsers (complete: @escaping (Int, [User]?)->()) {
        let url = BaseURL + "/get_all_users"
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    if let data = JSON as? Dictionary<String, Any> {
                        print("\nData: \(data)")
                        let result = data["result"] as! Int
                        if result != 0 {complete(result, nil)}
                        else {
                            let final = try! JSONSerialization.data(withJSONObject: data["details"]!)
                            let listUser = try! JSONDecoder().decode([User].self, from: final)
                            complete(result, listUser)
                        }
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
    }
    
    func getPreviousMessages(fromId: String, toId: String, complete: @escaping (Int, [[String]]?)->()) {
        let url = BaseURL + "/conservation/get_messages"
        let params: Parameters = [ "ids": fromId ]
        
        AF.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    if let data = JSON as? Dictionary<String, Any> {
                        print("\nData: \(data)")
                        let result = data["result"] as! Int
                        if result != 0 {complete(result, nil)}
                        else {
                            let final = try! JSONSerialization.data(withJSONObject: data["details"]!)
                            let messages = try! JSONDecoder().decode([String].self, from: final)
                            let listMessages = messages.map { MessageSupport().decodeMessage(userId: fromId, message: $0) }
                            complete(result, listMessages)
                        }
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
    }
}
