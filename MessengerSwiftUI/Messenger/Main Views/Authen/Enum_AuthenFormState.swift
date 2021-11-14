//
//  Enum_AuthenFormState.swift
//  Messenger
//
//  Created by Tín Nguyễn on 14/11/2021.
//

import SwiftUI

enum AuthenFormState {
    case login
    case register
    
    var title: String {
        switch self {
        case .login:
            return LocalText.login
        case .register:
            return LocalText.register
        }
    }
}

enum AuthenState {
    case verifyingToken
    case editing
    case verifyingInput
    case succeeded
    case failed
}
