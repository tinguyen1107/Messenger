//
//  SettingViewModel.swift
//  Messenger
//
//  Created by Tín Nguyễn on 14/11/2021.
//

import SwiftUI

class SettingViewModel: ObservableObject {
    @Published var info_popup: Bool = false
    @Published var authenModel: AuthenModel
    var info: VMButton
    var logOut: VMButton
    
    init(authenModel: AuthenModel) {
        self.authenModel = authenModel
        logOut = VMButton(
            title: "Log Out",
            action: {
                authenModel.logOut()
            },
            type: .text)
        info = VMButton(title: "App Information",
                        action: {},
                        type: .text)
        info.action = { self.info_popup.toggle() }
    }
}
