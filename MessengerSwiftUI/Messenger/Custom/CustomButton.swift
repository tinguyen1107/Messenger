//
//  CustomButton.swift
//  Messenger
//
//  Created by Trọng Tín on 07/08/2021.
//

import SwiftUI

struct ABC: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 35)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .cornerRadius(30)
    }
}

struct testButton: PreviewProvider {
    static var previews: some View {
        VStack{
            Button("hello", action: {
                
            })
                .buttonStyle(ABC())
        }
        
    }
}
