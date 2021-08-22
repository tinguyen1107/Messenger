//
//  CustomButton.swift
//  Messenger
//
//  Created by Trọng Tín on 07/08/2021.
//

import SwiftUI

struct SimpleButton: ButtonStyle {
    var color: Color = Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
    var textColor: Color = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: 35)
            .frame(maxWidth: .infinity)
            .background(color)
            .foregroundColor(textColor)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .cornerRadius(30)
            .font(.system(size: 18, weight: .semibold, design: .rounded))
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

struct IconTexField: View {
    @Binding var text: String
    var placeholder: String
    
    var vPadding: CGFloat = 20
    var hPadding: CGFloat = 20
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(.vertical, vPadding)
                .padding(.horizontal, hPadding)
//            TextField(
        }
        .background(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
//        .cornerRadius(39)
        .border(Color.black, width: 5)
        
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $text)
        }
        .onTapGesture {
            print("hello")
            
        }
        .onChange(of: text, perform: { value in
            print(text)
        })
//        .underlineTextField()
        .padding(.vertical, 10)
        .overlay(Rectangle().frame(height: 2).padding(.top, 35))
        .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
        .padding(10)
        
        //        .shadow(radius: 100)
        
    }
}



struct testButton: PreviewProvider {
    @State static var text = ""
    
    static var previews: some View {
        VStack (spacing: 50){
            TextField("hello", text: $text)
                .textFieldStyle(InputTextField())
            
            IconTexField(text: $text, placeholder: "Icon Text Field")
            
            Button("hello", action: {
                
            })
            .buttonStyle(SimpleButton(color: Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))))
        }.padding()
        
    }
}
