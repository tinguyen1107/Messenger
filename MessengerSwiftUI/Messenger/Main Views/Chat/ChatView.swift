//
//  ChatView.swift
//  Messenger
//
//  Created by Trọng Tín on 12/08/2021.
//

import SwiftUI

struct Message: View {
    @Binding var message: [String]
    
    var body: some View {
        let isUserSend = message[0] == "user"
        HStack {
            HStack {
                Text(message[1])
                    .foregroundColor(isUserSend ? .white : .black)
                    .frame(alignment: .leading)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 15)
            .background(isUserSend ? Color.blue.opacity(0.8) : Color(.systemGray4))
            .cornerRadius(12)
            .frame(maxWidth: UIScreen.main.bounds.width * 2/3, alignment: isUserSend ? .trailing : .leading)
        }
        .frame(maxWidth: UIScreen.main.bounds.width, alignment: isUserSend ? .trailing : .leading)
        .padding(.horizontal, 10)
    }
}

struct ChatView: View {
    var user: User
    var friend: User
    
    @State private var message: String = ""
    @State private var isTyping: Bool = false
    @State private var listMessages: [[String]] = []
    
    init (user: User, friend: User) {
        self.user = user
        self.friend = friend
    }

    var body: some View {
        VStack {
            ScrollView {
                ForEach (listMessages.indices, id: \.self) { index in
                    Message(message: $listMessages[index])
                }.padding(.top, 5)
            }
            
            Spacer()
                .frame(width: UIScreen.main.bounds.width, height: 1, alignment: .center)
                .background(Color(.systemGray4))
            
            HStack {
                HStack {
                    TextField("Type message here ...", text: $message)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(Color(.systemGray5))
                .cornerRadius(9)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .onTapGesture(perform: {
                    isTyping = true
                })
                .overlay(
                    HStack {
                        Spacer()
                        if isTyping {
                            Button(action: { message = "" }, label: {
                                Image(systemName: "xmark.circle.fill")
                            })
                        }
                    }
                    .padding(.horizontal, 32)
                    .foregroundColor(.gray)
                )
                if isTyping {
                    Button(action: {
                        isTyping = false
                        if (message != "") {
                            listMessages.append(["user", message])
                        }
                        message = ""
                        
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }, label: {
                        Text(message != "" ? "Send" : "Close")
                            .padding(.trailing)
                            .padding(.leading, -12)
                    })
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
            .onAppear {
                Alamofire().getPreviousMessages(fromId: user._id!, toId: friend._id!, complete: { result, messages in
                    if result == 0 {
                        listMessages = messages!
                    }
                })
            }
            .transition(.move(edge: .trailing))
            .animation(.default)
        }
        .navigationTitle(friend.fullname)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarColor(.lightGray)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: emptyUser, friend: User(_id: nil, email: "abc@gmail.com", password: "", fullname: "Noo"))
    }
}
