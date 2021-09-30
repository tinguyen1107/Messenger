//
//  User.swift
//  Messenger
//
//  Created by Trọng Tín on 13/08/2021.
//

import Foundation

struct User: Codable, Hashable {
    var _id: String
    var email: String
    var password: String
    var fullname: String
    var avatar: String
    var token: String
    
    init(_id: String = "", email: String = "", password: String = "", fullname: String = "", avatar: String = "", token: String = "") {
        self._id = _id
        self.email = email
        self.password = password
        self.fullname = fullname
        self.avatar = avatar
        self.token = token
    }
}

struct MessageSupport {
    func decodeMessage (self_userId: String, message: String)->[String] {
        return message.split(separator: "_", maxSplits: 1)
            .map { String($0) == self_userId ? "user" : String($0) }
    }
    
    func encodeMessage (userId: String, message: String)->String {
        return userId + "_" + message
    }
}
