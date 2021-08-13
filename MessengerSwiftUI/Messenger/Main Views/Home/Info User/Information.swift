//
//  Information.swift
//  Messenger
//
//  Created by Trọng Tín on 12/08/2021.
//

import SwiftUI

struct Information: View {
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
                        
                    }, label: {
                        Image(systemName: "moon.fill")
                            .padding(.horizontal)
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
//        .navigationBarHidden(true)
    }
}

struct Information_Previews: PreviewProvider {
    static var previews: some View {
        Information(user: User(_id: "", email: "nttin@gmail.com", password: "", fullname: "Nguyen Trong Tin"))
    }
}
