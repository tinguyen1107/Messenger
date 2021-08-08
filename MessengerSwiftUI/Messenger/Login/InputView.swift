//
//  InputView.swift
//  Messenger
//
//  Created by Trọng Tín on 07/08/2021.
//

import SwiftUI

struct InputView: View {
    //    @State private var username: String = ""
    @State private var user: User = User(name: "", password: "", age: "")
    @State private var isEditing: Bool = false
    @State private var state = "login"
    
    var body: some View {
        
        VStack{
            Picker(selection: $state, label: Text("")) {
                Text("Login").tag("login")
                Text("Register").tag("register")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, 10)
            .shadow(radius: 5)
            VStack {
                TextField ("User name", text: $user.name)
                TextField ("Password", text: $user.password)
                if state == "register" {
                    TextField ("Age", text: $user.age)
                }
            }
            .shadow(radius: 5)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                user = User(name: "", password: "", age: "")
            }, label: {
                HStack {
                    Text(state == "login" ? "Login" : "Register")
                }
            })
            .buttonStyle(ABC())
            .padding(.top, 10)
            .shadow(radius: 5)
            
            
        }
        .frame(width: UIScreen.main.bounds.width * 0.85)
        .animation(.default)
//        .onTapGesture {
//            self.endEditing()
//        }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}

struct User {
    var name: String
    var password: String
    var age: String
}
