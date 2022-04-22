//
//  InfoViewModel.swift
//  Messenger
//
//  Created by Tín Nguyễn on 20/11/2021.
//

import Foundation

class InfoViewModel: ObservableObject {
    @Published var authenModel: AuthenModel
    @Published var isEditMode: Bool
    
    @Published var logOutButtonViewModel: VMButton?
    var cancelButtonViewModel: VMButton?
    
    init(authenModel: AuthenModel) {
        self.isEditMode = false
        self.authenModel = authenModel
        
        self.logOutButtonViewModel = VMButton(
            title: "Log out",
            action: {
                authenModel.logOut()
            }, titleSecondary: "Cancel",
            actionSecondary: {
                print("Cancel")
                self.isEditMode.toggle()
                
            },
            isSecondary: _isEditMode,
            type: .text)
        
        self.cancelButtonViewModel = VMButton(
            title: "Change infomation",
            action: {
                print("11")
                self.isEditMode.toggle()
            },
            titleSecondary: "Save",
            actionSecondary: {
                print("22")
                self.isEditMode.toggle()
            },
            isSecondary: $isEditMode,
            type: .text)
    }
}
