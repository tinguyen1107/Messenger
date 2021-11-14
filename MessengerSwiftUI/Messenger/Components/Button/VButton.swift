//
//  VButton.swift
//  Messenger
//
//  Created by Tín Nguyễn on 14/11/2021.
//

import SwiftUI

struct VButton: View {
    var viewModel: VMButton
    
    init(viewModel: VMButton) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button(viewModel.title) {
            viewModel.action()
        }.buttonStyle(.automatic)
    }
}
struct VButton_Previews: PreviewProvider {
    static var previews: some View {
        VButton(viewModel: VMButton(title: "Testing", action: {
            print("hello")
        }, type: .text))
    }
}
