//
//  LoginView.swift
//  Messenger
//
//  Created by Trọng Tín on 07/08/2021.
//

import SwiftUI
import AVFoundation

struct AuthenView: View {
    @StateObject var authenModel: AuthenModel = AuthenModel()
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                Spacer()
                headerView
                    .frame(maxWidth: UIScreen.main.bounds.width)
                Spacer()
                if authenModel.authenState == .editing {
                    AuthenForm(authenModel: self.authenModel)
                        .transition(.move(edge: .bottom))
                        .animation(.linear)
                }
                NavigationLink(destination: HomeView(authenModel: self.authenModel),
                               tag: AuthenState.succeeded,
                               selection: $authenModel.authenState) { EmptyView() }.transition(.move(edge: .bottom))
                    .animation(.linear)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .ignoresSafeArea()
            .animation(.default)
            .onAppear {
                verifingToken()
//                if let device = AVCaptureDevice.default(.builtInDualCamera,
//                                                        for: .video, position: .back) {
//                    return device
//                } else if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
//                                                               for: .video, position: .back) {
//                    return device
//                } else {
//                    fatalError("Missing expected back camera device.")
//                }

                AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                        if response {
                            
                            //access granted
                        } else {

                        }
                    }
            }
        }
    }
}

extension AuthenView {
    var headerView: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("Messenger")
                    .font(localFont(.h1))
                    .foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                    .lineLimit(1)
                Text("Welcome to messenger!\nLet say something to your friend!")
                    .font(localFont(.description))
                    .foregroundColor(Color(#colorLiteral(red: 0.180785032, green: 0.5511000946, blue: 0.8088557696, alpha: 1)))
                    .lineLimit(2)
                    .padding(.top, 2)
            }
            .padding(.leading, 20)
            Spacer()
        }
    }
    
    func verifingToken () {
        let defaults = UserDefaults.standard
        if let oldUser = defaults.dictionary(forKey: "_USER"), let token = oldUser["token"] {
            print("TOKEN: \(token)")
            authenModel.authenState = .succeeded
        } else {
            print("THERE ARE NO TOKEN")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                authenModel.authenState = .editing
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenView()
            .environmentObject(DefaultController())
    }
}
