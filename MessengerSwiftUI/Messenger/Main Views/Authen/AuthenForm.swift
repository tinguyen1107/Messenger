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
    @ObservedObject var authenModel: AuthenModel

    public init(authenModel: AuthenModel) {
        self.authenModel = authenModel
    }
    
    var body: some View {
        ZStack{
            Wave(strength: 20, frequency: 10)
                .frame(height: UIScreen.main.bounds.height*0.6)
            VStack{
                Picker(selection: $authenModel.authenFormState, label: Text("")) {
                    Text(LocalText.login).tag(AuthenFormState.login)
                    Text(LocalText.register).tag(AuthenFormState.register)
                }
                .colorMultiply(Color(#colorLiteral(red: 0.5811089873, green: 0.8589370251, blue: 0.9827749133, alpha: 1)))
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 10)
                .shadow(radius: 5)
                
                contentView
                
                NavigationLink (destination: HomeView(authenModel: authenModel),
                                tag: AuthenState.succeeded,
                                selection: $authenModel.authenState) { EmptyView() }
                Button(action: {
                    authenModel.submit()
                }, label: {
                    HStack { Text(authenModel.authenFormState.title) }
                })
                .buttonStyle(SimpleButton(color: Color(#colorLiteral(red: 0.5811089873, green: 0.8589370251, blue: 0.9827749133, alpha: 1)), textColor: Color(#colorLiteral(red: 0.1396988332, green: 0.394677639, blue: 0.5602707863, alpha: 1))))
                .padding(.top, 10)
                .shadow(radius: 5)
            }
            .onChange(of: authenModel.authenState, perform: { newValue in
                if newValue == .succeeded {
                    services.user = self.authenModel.user
                    services.connect(user: User(_id: services.user._id, email: services.user.email, password: self.authenModel.authenFormState.title.lowercased(), fullname: services.user.fullname, avatar: "default", token: ""))
                }
            })
            .navigationBarHidden(true)
            .alert(item: $authenModel.selectedShow) { show in
                Alert(title: Text(show.title), message: Text(show.description ?? ""), dismissButton: .cancel())
            }
            .offset(y: kGuardian.slide)
            .onAppear { self.kGuardian.addObserver() }
            .onDisappear { self.kGuardian.removeObserver() }
            .padding(.horizontal, 20)
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
            
            if authenModel.authenFormState == .register {
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
        AuthenForm(authenModel: AuthenModel()).environmentObject(DefaultController())
    }
}
