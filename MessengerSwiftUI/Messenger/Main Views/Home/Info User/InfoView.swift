//
//  InfoView.swift
//  Messenger
//
//  Created by Trọng Tín on 12/08/2021.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.editMode) var editMode
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject var services: DefaultController
    
    var body: some View {
        ScrollView {
            if editMode?.wrappedValue == .inactive {
                Information()
            }
            else {
                Text("Editing...")
            }
            Button(action: {
                if editMode?.wrappedValue == .inactive {
                    editMode?.wrappedValue = .active
                } else {
                    editMode?.wrappedValue = .inactive
                }
            }, label: {
                HStack {
                    Text(editMode?.wrappedValue == .inactive ? "Edit" : "Done")
                }
                .padding(.vertical, 8)
                .frame(maxWidth: UIScreen.main.bounds.width)
                .background(Color(.systemGray5))
                .cornerRadius(9)
                .padding(.horizontal)
            })
            if editMode?.wrappedValue == .inactive {
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
        }
        .ignoresSafeArea(edges: .all)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
//        InfoView()
//            .environmentObject(DefaultController())
        Edit_InfoView()
            .environmentObject(DefaultController())
    }
}

struct Edit_InfoView: View {
    @EnvironmentObject var services: DefaultController
    
    var content: [[String]] {
        [
            ["Email", services.user.email],
            ["Full name", services.user.fullname],
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
                }
                Divider()
            }
            .padding(.horizontal)
        }
        .ignoresSafeArea(edges: .top)
    }
}
