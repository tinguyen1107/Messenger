//
//  HomeCard.swift
//  Messenger
//
//  Created by Trọng Tín on 11/08/2021.
//

import SwiftUI

struct SimpleCard: View {
    var name: String
    
    var body: some View {
        HStack {
            CircleImage(image: Image("rainbowlake").resizable())
                .frame(width: 55, height: 55)
           
            Text(name)
                .foregroundColor(.black)
                .padding(.leading, 10)
                .font(.caption)
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
    }
}

struct CircleImage: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .scaleEffect()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 4.0))
            .shadow(radius: 7)
    }
}

struct HomeCard_Previews: PreviewProvider {
    static var previews: some View {
        SimpleCard(name: "abc")
    }
}
