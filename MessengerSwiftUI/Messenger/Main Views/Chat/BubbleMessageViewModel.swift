//
//  BubbleChatViewModel.swift
//  Messenger
//
//  Created by Tín Nguyễn on 14/11/2021.
//

import SwiftUI

struct BubbleMessageViewModel {
    var isUserSend: Bool {self.sentBy == "user"}
    var type: MessageType
    
    var sentBy: String
    var content: String
        
    init (message: [String]) {
        self.sentBy = message[0]
        self.content = message[1]
        self.type = .text
    }
}
