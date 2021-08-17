//
//  User.swift
//  Messenger
//
//  Created by Trọng Tín on 13/08/2021.
//

import Foundation

struct User: Codable, Hashable {
    var _id: String?
    var email: String
    var password: String
    var fullname: String
}

struct MessageSupport {
    func decodeMessage (userId: String, message: String)->[String] {
        return message.split(separator: "_", maxSplits: 1)
            .map { String($0) == userId ? "user" : String($0) }
    }
    
    func encodeMessage (userId: String, message: String)->String {
        return userId + "_" + message
    }
}
