//
//  InfoView.swift
//  Messenger
//
//  Created by Trọng Tín on 12/08/2021.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var services: DefaultController

    @Environment(\.presentationMode) var presentation
 
    var body: some View {
        ScrollView {
            Information(user: services.user)
            
            Button(action: {
                self.presentation.wrappedValue.dismiss()
                services.user = emptyUser
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
        .ignoresSafeArea(edges: .all)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .environmentObject(DefaultController())
    }
}
