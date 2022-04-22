//
//  VMButton.swift
//  Messenger
//
//  Created by Tín Nguyễn on 14/11/2021.
//

import SwiftUI

enum LocalButtonStyle {
    case text
}

class VMButton: ObservableObject {
    var action: ()->Void
    var title: String
    var type: LocalButtonStyle
    
    var titleSecondary: String
    var actionSecondary: ()->Void
    
    var isSecondary: Published<Bool>.Publisher
    
    init (title: String, action: @escaping ()->Void, titleSecondary: String = "", actionSecondary: @escaping (()->Void) = {}, isSecondary: Published<Bool>.Publisher?, type: LocalButtonStyle) {
        self.title = title
        self.action = action
        self.type = type
        self.titleSecondary = titleSecondary
        self.actionSecondary = actionSecondary
        self.isSecondary = isSecondary!
    }
}
