//
//  InfoView_Edit.swift
//  Messenger
//
//  Created by Trọng Tín on 02/09/2021.
//

import SwiftUI

struct Infomation_Edit: View {
    @State private var showImagePicker: Bool = false
    @Binding var selectedUIImage: UIImage?
    
    @Binding var user: User

    var body: some View {
        ScrollView {
            Image("turtlerock_feature").resizable()
                .frame(maxWidth: UIScreen.main.bounds.width)
                .frame(height: UIScreen.main.bounds.height / 3)
            Button(action: {
                self.showImagePicker.toggle()
            }, label: {
            CircleImage(image: Image(uiImage: selectedUIImage!))
                .frame(width: 200, height: 200)
                .offset(y: -100)
                .padding(.bottom, -115)
            })
            VStack(alignment: .leading) {
                HStack {
                    Text("Editting...")
                        .font(.title2)
                    
                    Spacer()
                    
                    Button (action: {
                        
                    }, label: {
                        Image(systemName: "moon.fill")
                            .padding(.horizontal)
                    })
                }
                Divider()

                HStack (alignment: .center) {
                    VStack (alignment: .leading) {
                        Text("Full name")
                            .frame(width: 100, alignment: .leading)
                    }
                    Divider()
                    VStack (alignment: .trailing) {
                        TextField("...your full name here", text: $user.fullname)
                            .multilineTextAlignment(.trailing)
                            .frame(maxWidth: .infinity)
                    }
                }
                Divider()
            }
            .padding(.horizontal)
        }
        .ignoresSafeArea(edges: .top)
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(uiImage: $selectedUIImage)
        })
    }
}

//struct InfoView_Edit_Previews: PreviewProvider {
//    static var previews: some View {
////        Infomation_Edit(user: .constant(emptyUser))
//    }
//}
