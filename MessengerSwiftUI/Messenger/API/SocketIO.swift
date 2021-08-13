//
//  SocketIO.swift
//  Messenger
//
//  Created by Trọng Tín on 13/08/2021.
//

import Foundation
import SocketIO


let manager = SocketManager(socketURL: URL(string: "http://localhost:8080")!, config: [.log(true), .compress])
let socket = manager.defaultSocket

//class SocketIO {
//    func listen () {
//        socket.on(clientEvent: .connect) {data, ack in
//            print("socket connected")
//        }
//
//        socket.on("currentAmount") {data, ack in
//            guard let cur = data[0] as? Double else { return }
//
//            socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
//                if data.first as? String ?? "passed" == SocketAckValue.noAck {
//                    // Handle ack timeout
//                }
//
//                socket.emit("update", ["amount": cur + 2.50])
//            }
//
//            ack.with("Got your currentAmount", "dude")
//        }
//
//        socket.connect()
//    }
////    var manager: SocketManager
////    static var socket: SocketIOClient
//}

final class Service: ObservableObject {
    private var manager = SocketManager(socketURL: URL(string: BaseURL)!, config: [.log(true), .compress])
    var socket: SocketIOClient {
        manager.defaultSocket
    }
    @Published var messages = [String]()
    
    init() {
        socket.on(clientEvent: .connect) { (data, ack) in
            print ("Socket connected")
        }
        
        socket.on("") { [weak self] (data, ack) in
            if let data = data[0] as? [String: String],
               let rawMessage = data["msg"] {
                DispatchQueue.main.async {
                    self?.messages.append(rawMessage)
                }
            }
        }
    }
    
    func connect (user: User) {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(user)
        guard let final = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, String> else { return }
        socket.connect(withPayload: final)
    }
    
    func sendMessage (content: String, toId: String) {
        socket.emit("send_messsage", toId + "_" + content)
    }
    
    func disconnect () { socket.disconnect() }
}
