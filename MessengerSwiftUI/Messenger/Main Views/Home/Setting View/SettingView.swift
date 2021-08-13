//
//  SettingView.swift
//  Messenger
//
//  Created by Trọng Tín on 12/08/2021.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            ScrollView {
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
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
