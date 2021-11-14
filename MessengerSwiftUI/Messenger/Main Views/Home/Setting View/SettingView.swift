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
