//
//  InputView.swift
//  Messenger
//
//  Created by Trọng Tín on 19/08/2021.
//

import SwiftUI

struct InputView: View {
    
    @EnvironmentObject var services: DefaultController
    
    @State private var state = "login"
    @State private var willMoveToNextScreen = false
    @State private var selectedShow: AlertContent?
    
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
                TextField ("Email", text: $services.user.email)
                SecureField ("Password", text: $services.user.password)
                
                if state == "register" {
                    TextField ("Fullname", text: $services.user.fullname)
                }
            }
            .textFieldStyle(InputTextField())
            
            NavigationLink (destination: HomeView(user: services.user), isActive: $willMoveToNextScreen) { EmptyView() }
            Button(action: {
                Alamofire().login_register(state: state, user: services.user) { result, detail in
                    if result == 0 {
                        services.user = detail!
                        services.connect(user: User(_id: services.user._id, email: services.user.email, password: services.user.password, fullname: (state == "register" ? services.user.fullname : "")))
                        willMoveToNextScreen.toggle()
                    } else {
                        selectedShow = AlertContent(title: "Log in failed", description: "Please try again.")
                    }
                }
            }, label: {
                HStack { Text(state == "login" ? "Login" : "Register") }
            })
            .buttonStyle(SimpleButton(color: Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))))
            .padding(.top, 10)
            .shadow(radius: 5)
            
            
        }
        .navigationBarHidden(true)
        .alert(item: $selectedShow) { show in
            Alert(title: Text(show.title), message: Text(show.description), dismissButton: .cancel())
        }
//        .environmentObject(DefaultController())
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView().environmentObject(DefaultController())
    }
}
