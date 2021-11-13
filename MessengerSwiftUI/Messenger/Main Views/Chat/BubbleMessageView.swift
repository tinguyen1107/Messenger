//
//  BubbleMessageView.swift
//  Messenger
//
//  Created by Tín Nguyễn on 13/11/2021.
//

import SwiftUI

enum MessageType {
    case text
    case image
}

struct BubbleMessageView: View {
    var viewModel: BubbleMessageViewModel
    
    var body: some View {
        HStack {
            VStack (alignment: viewModel.isUserSend ? .trailing : .leading, spacing: 0) {
                
                if !viewModel.isUserSend {
                    Text(viewModel.sentBy)
                        .foregroundColor(.black.opacity(0.5))
                }
                HStack {
                    Text(viewModel.content)
                        .foregroundColor(viewModel.isUserSend ? .white : .black)
                        .frame(alignment: .leading)
                        .padding(.vertical, 8)

                }
                .padding(.horizontal, 15)
                .background(viewModel.isUserSend ? Color.blue.opacity(0.8) : Color(.systemGray4))
                .cornerRadius(12)
                .frame(maxWidth: UIScreen.main.bounds.width * 2/3, alignment: viewModel.isUserSend ? .trailing : .leading)
                Text("14:30")
                    .foregroundColor(.black.opacity(0.5))
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width, alignment: viewModel.isUserSend ? .trailing : .leading)
        .padding(.horizontal, 10)
    }
}

struct BubbleMessageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BubbleMessageView(viewModel: BubbleMessageViewModel(message: ["user", "this is content"]))
            BubbleMessageView(viewModel: BubbleMessageViewModel(message: ["Teo", "this is content"]))
        }
    }
}
