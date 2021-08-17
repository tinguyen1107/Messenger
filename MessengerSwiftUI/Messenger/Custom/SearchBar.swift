//
//  SearchBar.swift
//  Messenger
//
//  Created by Trọng Tín on 12/08/2021.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchKey: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField("Search for ...", text: $searchKey)
                    .padding(.leading, 24)
                //                .textFieldStyle(InputTextField())
            }
            .padding(.vertical, 7)
            .padding(.horizontal)
            .background(Color(.systemGray5))
            .cornerRadius(9)
            .padding(.horizontal)
            .onTapGesture(perform: {
                isSearching = true
            })
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if isSearching {
                        Button(action: { searchKey = "" }, label: {
                            Image(systemName: "xmark.circle.fill")
                        })
                    }
                }
                .padding(.horizontal, 32)
                .foregroundColor(.gray)
            )
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchKey = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, -12)
                })
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
        .transition(.move(edge: .trailing))
        .animation(.default)
        .padding(.vertical, 10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchKey = ""
    @State static var isSearching = false
    static var previews: some View {
        SearchBar(searchKey: $searchKey, isSearching: $isSearching)
    }
}
