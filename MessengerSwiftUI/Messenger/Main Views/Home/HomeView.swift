//
//  HomeView.swift
//  Messenger
//
//  Created by Trọng Tín on 11/08/2021.
//

import SwiftUI

struct HomeView: View {
    enum Tab {
        case info
        case listUser
        case listFriend
        case setting
        
        var title: String {
            switch self {
            case .info: return ""
            case .listUser: return "List user"
            case .listFriend: return "List friend"
            case .setting: return "Setting"
            }
        }
        
        var isHiddenNavigation: Bool {
            switch self {
            case .info: return false
            default: return true
            }
        }
    }
    
    var user: User
    @State private var selection: Tab = .listFriend
    
    var body: some View {
        TabView (selection: $selection) {
            InfoView(user: user)
                .tabItem {
                    Label("Users", systemImage: "person.crop.circle")
                }
                .tag(Tab.info)
            ListFriendView(user: user)
                .tabItem {
                    Label("Friends", systemImage: "bubble.left.and.bubble.right")
                }
                .tag(Tab.listFriend)
            ListUser(user: user)
                .tabItem {
                    Label("More friend", systemImage: "person.crop.circle.badge.plus")
                }
                .tag(Tab.listUser)
            SettingView()
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
                .tag(Tab.setting)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(selection.title)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView(user: User(_id: "", email: "ntrongtin11702@gmail.com", password: "", fullname: "Nguyễn Trọng Tín"))
        }
        
    }
}
