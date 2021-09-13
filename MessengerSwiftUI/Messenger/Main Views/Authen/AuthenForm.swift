//
//  InputView.swift
//  Messenger
//
//  Created by Trọng Tín on 19/08/2021.
//

import SwiftUI
import Alamofire

struct AuthenForm: View {
    @EnvironmentObject var services: DefaultController
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 3)
    
    @State private var state = "login"
    @State private var willMoveToNextScreen = false
    @State private var selectedShow: AlertContent?
    
    var body: some View {
        ZStack{
            Wave(strength: 20, frequency: 10)
                .frame(height: UIScreen.main.bounds.height*0.6)
            VStack{
                Picker(selection: $state, label: Text("")) {
                    Text("Login").tag("login")
                    Text("Register").tag("register")
                }
                .colorMultiply(Color(#colorLiteral(red: 0.5811089873, green: 0.8589370251, blue: 0.9827749133, alpha: 1)))
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 10)
                .shadow(radius: 5)
                
                contentView
                
                NavigationLink (destination: HomeView(), isActive: $willMoveToNextScreen) { EmptyView() }
                Button(action: {
                    submit()
                }, label: {
                    HStack { Text(state == "login" ? "Login" : "Register") }
                })
                .buttonStyle(SimpleButton(color: Color(#colorLiteral(red: 0.5811089873, green: 0.8589370251, blue: 0.9827749133, alpha: 1)), textColor: Color(#colorLiteral(red: 0.1396988332, green: 0.394677639, blue: 0.5602707863, alpha: 1))))
                .padding(.top, 10)
                .shadow(radius: 5)
            }
            .navigationBarHidden(true)
            .alert(item: $selectedShow) { show in
                Alert(title: Text(show.title), message: Text(show.description ?? ""), dismissButton: .cancel())
            }
            .offset(y: kGuardian.slide)
            .onAppear { self.kGuardian.addObserver() }
            .onDisappear { self.kGuardian.removeObserver() }
            .padding(.horizontal, 20)
        }
    }
}

extension AuthenForm {
    private func submit () {
        //        user: services.user
        let params: Parameters = [
            "email": services.user.email,
            "password": services.user.password
        ]
        Alamofire().login_register(state: state, params: params) { result, detail in
            if result == 0 {
                services.user = detail!
                services.connect(user: User(_id: services.user._id, email: services.user.email, password: state, fullname: services.user.fullname, avatar: "default", token: ""))
                willMoveToNextScreen.toggle()
            } else {
                selectedShow = AlertContent(title: "Log in failed", description: "Please try again.", dismiss: true)
            }
        }
    }
    
    private var contentView: some View {
        VStack {
            TextField ("Email", text: $services.user.email,
                       onEditingChanged: { if $0 { self.kGuardian.showField = 0 } })
                .background(GeometryGetter(rect: $kGuardian.rects[0]))
            
            SecureField ("Password", text: $services.user.password)
                .background(GeometryGetter(rect: $kGuardian.rects[1]))
                .onTapGesture {
                    self.kGuardian.showField = 1
                }
            
            if state == "register" {
                TextField ("Fullname", text: $services.user.fullname,
                           onEditingChanged: { if $0 { self.kGuardian.showField = 2 } })
                    .background(GeometryGetter(rect: $kGuardian.rects[2]))
            }
        }
        .textFieldStyle(InputTextField())
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenForm().environmentObject(DefaultController())
    }
}
