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
    
    var cls_Conservation: (()->Void)?
    
    @Published var user = emptyUser
    @Published var friends: [User] = []
    @Published var messages: [String: [String]] = [:]
    
    init() {
        socketListening()
    }
    
    func socketListening () {
        socket.on(clientEvent: .connect) { (data, ack) in
            print ("Socket connected")
        }
        
        socket.on("receive_message") { (data, ack) in
            if let rawMessage = data[0] as? String
//               let rawMessage = data["message"]
            {
                DispatchQueue.main.async { [self] in
                    let result = MessageSupport().decodeMessage(self_userId: user._id, message: rawMessage)
                    if result[0] != "user" {
                        if let _ = messages[result[0]] {
                            messages[result[0]]!.append(rawMessage)
                        } else {
                            messages[result[0]] = [rawMessage]
                        }
                        
                    }
                }
            }
        }

        socket.on("respone_create_conservation") { data, ack in
            self.cls_Conservation!()
        }
        socket.on("someone_create_consevation_receive") { data, ack in
            let final = try! JSONSerialization.data(withJSONObject: data[0] as Any)
            let newFriend = try! JSONDecoder().decode(User.self, from: final)
            DispatchQueue.main.async {
                self.friends.append(newFriend)
            }
        }
    }
    
    func connect (user: User) {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(user)
        guard let final = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, String> else { return }
        socket.connect(withPayload: final)
    }
    
    func addFriend (newFriend: User, completion: @escaping (Bool)->()) {
        cls_Conservation = {
            DispatchQueue.main.async {
                self.friends.append(newFriend)
                completion(true)
            }
        }
        
        socket.emit("create_conservation_submit", newFriend._id)
    }
    
    func sendMessage (content: String, toId: String) {
        socket.emit("send_messsage", MessageSupport().encodeMessage(userId: toId, message: content))
    }
    
    func disconnect () { socket.disconnect() }
}
