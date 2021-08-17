//
//  UserDetails.swift
//  Messenger
//
//  Created by Trọng Tín on 13/08/2021.
//

import SwiftUI

struct UserDetails: View {
    @EnvironmentObject var services: DefaultController
    
    var user: User
    var content: [[String]] {
        [
            ["Email", user.email],
            ["Full name", user.fullname],
        ]
    }
    
    var body: some View {
        ScrollView {
            Image("turtlerock_feature").resizable()
                .frame(maxWidth: UIScreen.main.bounds.width)
                .frame(height: UIScreen.main.bounds.height / 3)

            CircleImage(image: Image("rainbowlake"))
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                HStack {
                    Text("Information")
                        .font(.title)
                    
                    Spacer()
                    
                    Button (action: {
                        services.addFriend(newFriend: user)
                    }, label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add friend")
                        }
                        .padding(7)
                        .background(Color(.systemGray4))
                        .cornerRadius(9)
                    })
                }

                ForEach(content, id: \.self) { content in
                    Divider()
                    HStack (alignment: .top) {
                        VStack (alignment: .leading) {
                            Text(content[0])
                                .frame(width: 100, alignment: .leading)
                        }
                        Divider()
                        VStack (alignment: .trailing) {
                            Text(content[1])
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .foregroundColor(.black)
                }
                Divider()
            }
            .padding(.horizontal)
        }
        .ignoresSafeArea(edges: .top)
    }
}

struct UserDetails_Previews: PreviewProvider {
    static var previews: some View {
        UserDetails(user: User(_id: "", email: "nttin@gmail.com", password: "", fullname: "Nguyen Trong Tin"))
    }
}
