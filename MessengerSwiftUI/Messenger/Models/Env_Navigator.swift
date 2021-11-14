//
//  Env_Navigator.swift
//  Messenger
//
//  Created by Tín Nguyễn on 14/11/2021.
//

import Foundation
import SwiftUI

class AuthenModel: ObservableObject {
    @Published var authenState: AuthenState?
    var token: String?
    
    init () {
        authenState = .verifyingToken
        self.verifingToken()
    }
    
    func verifingToken () {
        let defaults = UserDefaults.standard
        if let oldUser = defaults.dictionary(forKey: "_USER"), let token = oldUser["token"] {
            print("TOKEN: \(token)")
            authenState = .succeeded
        } else {
            print("THERE ARE NO TOKEN")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.authenState = .editing
            }
        }
    }
}
