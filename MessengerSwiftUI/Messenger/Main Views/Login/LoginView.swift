//
//  LoginView.swift
//  Messenger
//
//  Created by Trọng Tín on 07/08/2021.
//

import SwiftUI

struct User: Codable, Hashable {
    var _id: String?
    var email: String
    var password: String
    var fullname: String
}

struct AlertContent: Identifiable {
    var id: String { title }
    let title: String
    let description: String
}

struct LoginView: View {
    
    
    @State private var state = "login"
    @State private var willMoveToNextScreen = false
    @State private var selectedShow: AlertContent?
    
    @State private var user: User = User(_id: nil, email: "", password: "", fullname: "")
    @State private var listUser: [User] = []
    
    var body: some View {
        NavigationView {
            VStack{
                Picker(selection: $state, label: Text("")) {
                    Text("Login").tag("login")
                    Text("Register").tag("register")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 10)
                .shadow(radius: 5)
                VStack {
                    TextField ("Email", text: $user.email)
                    SecureField ("Password", text: $user.password)
                        
                    if state == "register" {
                        TextField ("Age", text: $user.fullname)
                    }
                }
                .textFieldStyle(InputTextField())
                
                NavigationLink (destination: HomeView(user: user), isActive: $willMoveToNextScreen) { EmptyView() }
                Button(action: {
//                    willMoveToNextScreen.toggle()
                    Alamofire().login_register(state: state, user: user) { result, detail in
                        if result == 0 {
                            self.user = detail!
                            
                            Service().connect(user: user)
                            willMoveToNextScreen.toggle()
                        } else {
                            selectedShow = AlertContent(title: "Log in failed", description: "Please try again.")
                        }
                    }
                }, label: {
                    HStack {
                        Text(state == "login" ? "Login" : "Register")
                    }
                })
                .buttonStyle(SimpleButton())
                .padding(.top, 10)
                .shadow(radius: 5)
                
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.85)
            .animation(.default)
            .navigationBarHidden(true)
            .alert(item: $selectedShow) { show in
                Alert(title: Text(show.title), message: Text(show.description), dismissButton: .cancel())

            }
        }
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .shadow(color: .gray, radius: 10)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
