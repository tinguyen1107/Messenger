//
//  ListUser.swift
//  Messenger
//
//  Created by Trọng Tín on 10/08/2021.
//

import SwiftUI

struct ListUser: View {
    var user: User
    @State private var searchKey: String = ""
    @State private var isSearching: Bool = false
    
    @State private var selection: String? = nil
    
    @State private var chosenPeople: User = User(_id: "", email: "", password: "", fullname: "")
    @State private var listUser: [User] = []

    var body: some View {
        VStack {
            NavigationLink(destination: UserDetails(user: chosenPeople), tag: "InfoUser", selection: $selection) { EmptyView() }
            SearchBar(searchKey: $searchKey, isSearching: $isSearching)
            List(searchFor(key: searchKey), id: \.self) { people in
                Button(action: {
                    chosenPeople = people
                    self.selection = "InfoUser"
                }, label: {
                    SimpleCard(name: people.fullname)
                })
            }
        }
        .onAppear {
            Alamofire().getAllUsers(complete: { result, details in
                if result == 0 {
                    self.listUser = details!
                }
            })
        }
    }
    
    func searchFor (key: String) -> [User] {
        return listUser.filter({ $0.fullname.contains(searchKey) || searchKey == ""})
    }
}

struct ListUser_Previews: PreviewProvider {
    static var previews: some View {
        ListUser(user: User(email: "", password: "", fullname: ""))
    }
}
