//
//  CustomButton.swift
//  Messenger
//
//  Created by Trọng Tín on 07/08/2021.
//

import SwiftUI

struct SimpleButton: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 35)
            .frame(maxWidth: .infinity)
            .background(color)
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .cornerRadius(30)
    }
}

struct InputTextField: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .shadow(radius: 5)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}



struct testButton: PreviewProvider {
    static var previews: some View {
        VStack{
            Button("hello", action: {
                
            })
                .buttonStyle(SimpleButton(color: Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))))
        }
        
    }
}
