//
//  User.swift
//  Messenger
//
//  Created by Trọng Tín on 09/08/2021.
//

import Foundation

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

class Message: Codable {
    internal init(content: String? = nil, from: String? = nil, to: String? = nil, time: String? = nil) {
        self.content = content
        self.from = from
        self.to = to
        self.time = time
    }
    
    var content: String?
    var from: String?
    var to: String?
    var time: String?
}
