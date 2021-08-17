//
//  ListFriendView.swift
//  Messenger
//
//  Created by Trọng Tín on 12/08/2021.
//

import SwiftUI

struct ListFriendView: View {
    @EnvironmentObject var services: DefaultController
    
//    var user: User
    @State private var searchKey: String = ""
    @State private var isSearching: Bool = false
    
    @State private var selected: String? = nil
    @State private var choosenUser: User = emptyUser
    
    @State var listFriend: [User] = []
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                NavigationLink(destination: ChatView(friend: choosenUser), tag: "ChatView", selection: $selected) { EmptyView() }
                NavigationLink(destination: ChatView(friend: choosenUser), tag: "UserView", selection: $selected) { EmptyView() }
                
                SearchBar(searchKey: $searchKey, isSearching: $isSearching)
                ForEach (services.friends.filter({ $0.fullname.contains(searchKey) || searchKey == ""}), id: \.self) { friend in
                    Button  {
                        choosenUser = friend
                        self.selected = "ChatView"
                    } label: {
                        SimpleCard(name: friend.fullname)
                    }
                }
            }
            .onAppear {
                if services.friends == [] {
                    Alamofire().getAllUsersWithConservation(fromId: services.user._id!, complete: { result, friends in
                        if result == 0 {
                            self.services.friends = friends!
                        }
                    })
                }
            }
        }
    }
    
//    func searchFor (key: String) -> [User] {
//        return services.friends.filter({ $0.fullname.contains(searchKey) || searchKey == ""})
//    }
}

struct ListFriendView_Previews: PreviewProvider {
    static var previews: some View {
        ListFriendView()
    }
}
