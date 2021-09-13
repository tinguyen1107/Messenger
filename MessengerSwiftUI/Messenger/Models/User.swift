//
//  User.swift
//  Messenger
//
//  Created by Trọng Tín on 13/08/2021.
//

import Foundation

class User: Codable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
        hasher.combine(fullname)
        hasher.combine(avatar)
        hasher.combine(token)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.email == rhs.email
    }
    
    var _id: String
    var email: String
    var password: String
    var fullname: String
    var avatar: String
    var token: String
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
