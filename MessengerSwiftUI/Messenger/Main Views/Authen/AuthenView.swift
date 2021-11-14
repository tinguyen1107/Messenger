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
                authenModel.verifingToken()
            }
        }
    }
    
    var headerView: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(LocalText.app_name)
                    .font(localFont(.h1))
                    .foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                    .lineLimit(1)
                Text(LocalText.short_description)
                    .font(localFont(.description))
                    .foregroundColor(Color(#colorLiteral(red: 0.180785032, green: 0.5511000946, blue: 0.8088557696, alpha: 1)))
                    .lineLimit(2)
                    .padding(.top, 2)
            }
            .padding(.leading, 20)
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenView()
            .environmentObject(DefaultController())
    }
}
