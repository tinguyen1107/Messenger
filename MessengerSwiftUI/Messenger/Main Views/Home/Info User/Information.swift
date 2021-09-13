//
//  Information.swift
//  Messenger
//
//  Created by Trọng Tín on 12/08/2021.
//

import SwiftUI

struct Information: View {
    var user: User
    var avatar: UIImage
    
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

            CircleImage(image: Image(uiImage: avatar))
                .frame(width: 200, height: 200) 
                .offset(y: -100)
                .padding(.bottom, -115)
                

            VStack(alignment: .leading) {
                HStack {
                    Text("Information")
                        .font(.title2)
                    
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
                }
                Divider()
            }
            .padding(.horizontal)
        }
        .ignoresSafeArea(edges: .top)
    }
}

//struct Information_Previews: PreviewProvider {
//    static var previews: some View {
//        Information(user: emptyUser)
//            .environmentObject(DefaultController())
//    }
//}
