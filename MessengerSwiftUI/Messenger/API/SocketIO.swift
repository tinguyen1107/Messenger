//
//  SocketIO.swift
//  Messenger
//
//  Created by Trọng Tín on 13/08/2021.
//

import Foundation
import SocketIO

//let manager = SocketManager(socketURL: URL(string: BaseURL)!, config: [.log(true), .compress])
//let socket = manager.defaultSocket
let emptyUser = User (_id: "", email: "", password: "", fullname: "")

final class DefaultController: ObservableObject {
    
    private var manager = SocketManager(socketURL: URL(string: BaseURL)!, config: [.log(true), .compress])
    
    public var socket: SocketIOClient {
        manager.defaultSocket
    }
    
    @Published var user = User(_id: "", email: "", password: "", fullname: "")
    @Published var friends: [User] = []
    @Published var messages: Dictionary<String, [String]> = [:]
    
    init() {
        socketListening()
    }
    
    func socketListening () {
        socket.on(clientEvent: .connect) { (data, ack) in
            print ("Socket connected")
        }
        
        socket.on("receive_message") { [weak self] (data, ack) in
            if let data = data[0] as? [String: String],
               let rawMessage = data["message"] {
                DispatchQueue.main.async {
//                    MessageSupport().decodeMessage(userId: <#T##String#>, message: T##String)

//                    self?.messages.append(rawMessage)
                }
            }
        }
    }
    
//    func login (email: String, password: String) {
//
//    }
    
    func connect (user: User) {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(user)
        guard let final = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, String> else { return }
        socket.connect(withPayload: final)
    }
    
    func sendMessage (content: String, toId: String) {
        socket.emit("send_messsage", MessageSupport().encodeMessage(userId: self.user._id!, message: content))
    }
    
    func disconnect () { socket.disconnect() }
}
