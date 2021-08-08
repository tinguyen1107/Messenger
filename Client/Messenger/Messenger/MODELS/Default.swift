//
//  Default.swift
//  Messenger
//
//  Created by Trọng Tín on 29/07/2021.
//

import Foundation

class Default {
    static var user = User()
    static var listFriend = [friend]()
}
//
//class User {
//    var userID: String = ""
//    var username: String = ""
//    var sessionID: String = ""
//}

class friend {
    internal init(userID: String = "", username: String = "", connect: Bool = false) {
        self.userID = userID
        self.username = username
        self.connect = connect
    }
    
    var userID: String = ""
    var username: String = ""
    var connect: Bool = false
}
