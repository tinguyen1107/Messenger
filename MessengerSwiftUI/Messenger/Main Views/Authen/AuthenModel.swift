//
//  AuthenModel.swift
//  Messenger
//
//  Created by Tín Nguyễn on 20/11/2021.
//

import Foundation
import Alamofire

enum AuthenState {
    case verifyingToken
    case editing
    case verifyingInput
    case succeeded
    case failed
}

class AuthenModel: ObservableObject {
    @Published var authenState: AuthenState?
    @Published var user: User
    @Published var authenFormState: AuthenFormState
    @Published var selectedShow: AlertContent?

    var token: String?
    
    let old_user_key = "_USER"
    let token_key = "token"
    let email_key = "email"
    let password_key = "password"
    let fullname_key = "fullname"
    
    
    init () {
        self.authenState = .verifyingToken
        self.user = emptyUser
        self.authenFormState = .login
        
        self.verifingToken()
    }
    
    func verifingToken () {
        let defaults = UserDefaults.standard
        if let oldUser = defaults.dictionary(forKey: old_user_key), let token = oldUser[token_key] {
            print("TOKEN: \(token)")
            authenState = .succeeded
        } else {
            print("THERE ARE NO TOKEN")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.authenState = .editing
            }
        }
    }
    
    func submit () {
        var params: Parameters = [
            email_key: user.email,
            password_key: user.password
        ]
        
        if self.authenFormState == .register {
            params[fullname_key] = user.fullname
        }
        
        Alamofire().login_register(state: authenFormState.title.lowercased(), params: params) { result, detail in
            if result == 0 {
                self.user = detail!
                self.authenState = .succeeded
            } else {
                self.selectedShow = AlertContent(title: "Log in failed", description: "Please try again.", dismiss: true)
            }
        }
    }
    
    func logOut () {
        print ("LogOut")
    }
}
