//
//  InfoView.swift
//  Messenger
//
//  Created by Trọng Tín on 12/08/2021.
//

import SwiftUI
import UIKit
import AVFAudio

struct InfoView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var services: DefaultController
    
    @ObservedObject var viewModel: InfoViewModel
    
    @State private var editUser: User = emptyUser
    @State private var avatar: UIImage? = UIImage(named: "rainbowlake")
    
    var body: some View {
        ScrollView {
            if !viewModel.isEditMode {
                Information(user: services.user, avatar: avatar!)
            } else {
                Infomation_Edit(selectedUIImage: $avatar, user: $editUser)
                    .onAppear{
                        editUser = services.user
                    }
            }
//            Button(action: {
//                if viewModel.isEditMode { saveEdited() }
//                viewModel.isEditMode.toggle()
//            }, label: {
//                SimpleButtonView(title: !viewModel.isEditMode ? "Change Info" : "Save")
//            })
//            Button(action: {
//                if isEditMode { isEditMode.toggle() }
//                else { logOut() }
//            }, label: {
//                SimpleButtonView(title: !isEditMode ? "Log out" : "Cancle")
//            })
            VButton(viewModel: viewModel.cancelButtonViewModel!)
            VButton(viewModel: viewModel.logOutButtonViewModel!)
        }
        .ignoresSafeArea(edges: .all)
        .onAppear{
            loadAvatar()
        }
    }
    
    func logOut() {
        self.presentation.wrappedValue.dismiss()
        services.user = emptyUser
    }
 
    func saveEdited () {
        services.user = editUser
        Alamofire().upload(image: (avatar?.jpegData(compressionQuality: 1))!, imageName: "avatar", params: ["_id": services.user._id,"fullname": services.user.fullname])
    }
    
    func loadAvatar () {
        if services.user.avatar != "default" {
            Alamofire().downloadImage(filename: services.user.avatar) {
                avatar = $0
            }
        }
    }
}

//struct InfoView_Previews: PreviewProvider {
//    static var env = DefaultController()
//
//    static var previews: some View {
//        env.user = User(_id: "123", email: "ntrongtin11702@gmail.com", password: "123456", fullname: "Nguyen trong tin", avatar: "default", token: "")
//        return (
//            InfoView()
//                .environmentObject(env)
//        )
//
//    }
//}
