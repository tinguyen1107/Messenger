//
//  BackgroundLoginView.swift
//  Messenger
//
//  Created by Trọng Tín on 19/08/2021.
//

import SwiftUI

struct Wave: View {
    let timer = Timer.publish(every: 0.06, on: .main, in: .common).autoconnect()
    
    @State var x: CGFloat = -1.0
    @State var range: CGFloat = 0
    
    var strength: CGFloat
    var frequency: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            path(in: CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height), delta: 5.5)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))]),
                        startPoint: .bottom, endPoint: .top
                    )
                )
            path(in: CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height), delta: 4.5)
                .fill(Color(.white))
            
        }
        .onReceive(timer, perform: { _ in
            range += 0.1
        })
    }
    
    func path(in rect: CGRect, delta: CGFloat) -> Path {
        let path = UIBezierPath()
 
        let width = rect.width
        let height = rect.height
        let baseHeight = height * 1/15
    
        let wavelength = width / frequency
        path.move(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
    
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / wavelength
            let sine = sin(relativeX + self.range*delta/4.5 + delta)
            let y = strength * sine + baseHeight
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        return Path(path.cgPath)
    }
}
