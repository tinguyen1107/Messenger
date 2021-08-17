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
    
    @Published var user = emptyUser
    @Published var friends: [User] = []
    @Published var messages: Dictionary<String, [String]> = [:]
    
    init() {
        socketListening()
    }
    
    func socketListening () {
        socket.on(clientEvent: .connect) { (data, ack) in
            print ("Socket connected")
        }
        
//        socket.on("receive_message") { [weak self] (data, ack) in
//            if let data = data[0] as? [String: String],
//               let rawMessage = data["message"] {
//                DispatchQueue.main.async {
////                    MessageSupport().decodeMessage(userId: <#T##String#>, message: T##String)
//
////                    self?.messages.append(rawMessage)
//                }
//            }
//        }
//
        socket.on("someone_create_consevation_receive") { data, ack in
            let newFriend = try! JSONDecoder().decode(User.self, from: data[0] as! Data)
            DispatchQueue.main.async {
                self.friends.append(newFriend)
            }
        }
//
//        socket.on("respone_create_conservation") { data, ack in
//            <#code#>
//        }
    }
    
    func connect (user: User) {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(user)
        guard let final = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, String> else { return }
        socket.connect(withPayload: final)
    }
    
    func addFriend (newFriend: User) {
        socket.on("respone_create_conservation") { data, ack in
            DispatchQueue.main.async {
                self.friends.append(newFriend)
            }
        }
        
        socket.emit("create_conservation_submit", newFriend._id!)
    }
    
    func sendMessage (content: String, toId: String) {
        socket.emit("send_messsage", MessageSupport().encodeMessage(userId: self.user._id!, message: content))
    }
    
    func disconnect () { socket.disconnect() }
}
