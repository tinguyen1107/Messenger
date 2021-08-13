//
//  InfoView.swift
//  Messenger
//
//  Created by Trọng Tín on 12/08/2021.
//

import SwiftUI

struct InfoView: View {
    var user: User
    
    @Environment(\.presentationMode) var presentation
 
    var body: some View {
        ScrollView {
            Information(user: user)
            
            Button(action: {
                self.presentation.wrappedValue.dismiss()
            }, label: {
                HStack {
                    Text("Log out")
                }
                .padding(.vertical, 8)
                .frame(maxWidth: UIScreen.main.bounds.width)
                .background(Color(.systemGray5))
                .cornerRadius(9)
                .padding(.horizontal)
            })
        }
        .ignoresSafeArea(edges: .top)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(user: User(_id: "", email: "nttin@gmail.com", password: "", fullname: "Nguyen Trong Tin"))
    }
}
