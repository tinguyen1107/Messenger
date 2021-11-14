//
//  SettingView.swift
//  Messenger
//
//  Created by Trọng Tín on 12/08/2021.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var viewModel: SettingViewModel
   
    var body: some View {
//        ScrollView {
//            Button(action: {
//                self.presentation.wrappedValue.dismiss()
//            }, label: {
//                HStack {
//                    Text("Log out")
//                }
//                .padding(.vertical, 8)
//                .frame(maxWidth: UIScreen.main.bounds.width)
//                .background(Color(.systemGray5))
//                .cornerRadius(9)
//                .padding(.horizontal)
        //            })
        //            .padding(.vertical, 10)
        //        }
      
        List {
            Button("Hello") {
                
            }.buttonStyle(.automatic)
            VButton(viewModel: viewModel.info)
            VButton(viewModel: viewModel.logOut)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(viewModel: SettingViewModel(authenModel: AuthenModel()))
    }
}

class SettingViewModel: ObservableObject {
    @Published var info_popup: Bool = false
    @Published var authenModel: AuthenModel
    var info: VMButton
    var logOut: VMButton
    
    init(authenModel: AuthenModel) {
        self.authenModel = authenModel
        logOut = VMButton(title: "Log Out",
                                 action: { authenModel.authenState = .editing },
                                 type: .text)
        info = VMButton(title: "App Information",
                               action: {},
                               type: .text)
        info.action = { self.info_popup.toggle() }
    }
}

struct cusButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}


