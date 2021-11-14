//
//  Alamofire.swift
//  Messenger
//
//  Created by Trọng Tín on 10/08/2021.
//

import Foundation
import Alamofire
import SwiftUI

let BaseURL = "http://localhost:9000"

struct Alamofire {
    
//    func verifyToken (token: String, complete: @escaping (Int, User?)->()) {
//        let url = BaseURL + "/" + state
//    }
//    let params: Parameters = [ "ids": [fromId, toId] ]
    func login_register (state: String, params: Parameters, complete: @escaping (Int, User?)->()) {
        let url = BaseURL + "/" + state
        
        AF.request(url, method: .post, parameters: params)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    if let data = JSON as? Dictionary<String, Any> {
                        let final = try! JSONSerialization.data(withJSONObject: data)
                        let user = try! JSONDecoder().decode(User.self, from: final)
                        print(user)
                        UserDefaults.standard.setValue(["token": user.token], forKey: "_USER")
                        complete(0, user)
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    complete(1, nil)
                }
            }
    }
    
    func getAllFriends (fromId: String, complete: @escaping (Int, [User]?)->()) {
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
    
    func getPreviousMessages(fromId: String, toId: String, complete: @escaping (Int, [String]?)->()) {
        let url = BaseURL + "/conservation/get_messages"
        let params: Parameters = [ "ids": [fromId, toId] ]
        
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
                            complete(result, messages)
                        }
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
    }
    
    func upload(image: Data, imageName: String, params: [String: Any]) {
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            multiPart.append(image, withName: "avatar", fileName: imageName + ".png", mimeType: "image/png")
        }, to: BaseURL + "/user/info/edit", method: .post)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        .responseJSON(completionHandler: { data in
            print(data)
        })
    }

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(filename: String, completion: @escaping (UIImage) -> ()) {
        print("Download Started")
        let url = URL(string: BaseURL + "/file/" + filename)!
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() {
//                let uiImage = UIImage(data: data)
                completion(UIImage(data: data)!)
            }
        }
    }
}
