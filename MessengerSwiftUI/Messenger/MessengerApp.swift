//
//  MessengerApp.swift
//  Messenger
//
//  Created by Trọng Tín on 07/08/2021.
//

import SwiftUI

@main
struct MessengerApp: App {
    @StateObject var services: Services = Services()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(services)
        }
    }
}
