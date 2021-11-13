//
//  BubbleMessageView.swift
//  Messenger
//
//  Created by Tín Nguyễn on 13/11/2021.
//

import SwiftUI

struct BubbleMessageView: View {
    var message: [String]
    
    var body: some View {
        let isUserSend = message[0] == "user"
        HStack {
            VStack (alignment: .trailing, spacing: 0) {
                
                if !isUserSend {
                    Text(message[0])
                        .foregroundColor(.black.opacity(0.5))
                }
                HStack {
                    Text(message[1])
                        .foregroundColor(isUserSend ? .white : .black)
                        .frame(alignment: .leading)
                        .padding(.vertical, 8)

                }
                .padding(.horizontal, 15)
                .background(isUserSend ? Color.blue.opacity(0.8) : Color(.systemGray4))
                .cornerRadius(12)
                .frame(maxWidth: UIScreen.main.bounds.width * 2/3, alignment: isUserSend ? .trailing : .leading)
                Text("14:30")
                    .foregroundColor(.black.opacity(0.5))
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width, alignment: isUserSend ? .trailing : .leading)
        .padding(.horizontal, 10)
    }
}

struct BubbleMessageView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleMessageView(message: ["user", "this is content"])
    }
}
