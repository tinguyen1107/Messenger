//
//  ListUser.swift
//  Messenger
//
//  Created by Trọng Tín on 10/08/2021.
//

import SwiftUI

struct ListUser: View {
    @EnvironmentObject var services: DefaultController
    
    @State private var searchKey: String = ""
    @State private var isSearching: Bool = false
    
    @State private var selection: String? = nil
    
    @State private var chosenPeople: User = emptyUser
    @State private var listUser: [User] = []
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                NavigationLink(destination: UserDetails(user: chosenPeople), tag: "InfoUser", selection: $selection) { EmptyView() }
                
                SearchBar(searchKey: $searchKey, isSearching: $isSearching)
                ForEach(searchFor(key: searchKey), id: \.self) { people in
                    Button {
                        chosenPeople = people
                        self.selection = "InfoUser"
                    } label: {
                        SimpleCard(name: people.fullname)
                    }
                }
            }
            .onAppear {
                setupData()
            }
        }
    }
}

extension ListUser {
    func setupData() {
        Alamofire().getAllUsers(complete: { result, details in
            if result == 0 {
                self.listUser = details!
            }
        })
    }
    
    func searchFor (key: String)->[User] {
        return listUser.filter({$0._id != services.user._id}).filter({ $0.fullname.contains(searchKey) || searchKey == ""})
    }
}

struct ListUser_Previews: PreviewProvider {
    static var previews: some View {
        ListUser()
    }
}
