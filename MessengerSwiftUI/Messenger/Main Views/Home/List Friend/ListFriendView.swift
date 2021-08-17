//
//  ListFriendView.swift
//  Messenger
//
//  Created by Trọng Tín on 12/08/2021.
//

import SwiftUI

struct ListFriendView: View {
    var user: User
    @State private var searchKey: String = ""
    @State private var isSearching: Bool = false
    
    @State private var selected: String? = nil
    @State private var choosenUser: User = User(_id: "", email: "", password: "", fullname: "")
    
    @State var listFriend: [User] = []
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                NavigationLink(destination: ChatView(user: user, friend: choosenUser), tag: "ChatView", selection: $selected) { EmptyView() }
                NavigationLink(destination: ChatView(user: user, friend: choosenUser), tag: "UserView", selection: $selected) { EmptyView() }
                
                SearchBar(searchKey: $searchKey, isSearching: $isSearching)
                ForEach (searchFor(key: searchKey), id: \.self) { friend in
                    Button  {
                        choosenUser = friend
                        self.selected = "ChatView"
                    } label: {
                        SimpleCard(name: friend.fullname)
                    }
                }
            }
            .onAppear {
                Alamofire().getAllUsersWithConservation(fromId: user._id!, complete: { result, friends in
                    if result == 0 {
                        self.listFriend = friends!
                    }
                })
            }
        }
    }
    
    func searchFor (key: String) -> [User] {
        return listFriend.filter({ $0.fullname.contains(searchKey) || searchKey == ""})
    }
}

struct ListFriendView_Previews: PreviewProvider {
    static var previews: some View {
        ListFriendView(user: emptyUser)
    }
}
