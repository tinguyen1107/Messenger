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
    
    init (title: String, action: @escaping ()->Void, type: LocalButtonStyle) {
        self.title = title
        self.action = action
        self.type = type
    }
}
