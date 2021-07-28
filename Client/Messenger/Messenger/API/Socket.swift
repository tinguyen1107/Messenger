//
//  SupportSocket.swift
//  TestSocket
//
//  Created by Trọng Tín on 23/07/2021.
//

import Foundation
import SocketIO

class Socket {
    
    var manager: SocketManager
    var socket: SocketIOClient

    init(url: String) {
        print("Let connect")
        
        manager = SocketManager(socketURL: URL(string: url)!, config: [
//                                    .log(true),
                                    .compress])
//        manager.defaultSocket.connect(withPayload: ["auth": "xxx"])
        socket = manager.defaultSocket
        
        socket.connect(withPayload: ["auth": "xxx", "username": "tinguyen"])
    }
    
    func isConnected () {
        print("let check")
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
    }
    
    func connect () {
        socket.connect(withPayload: ["auth": "xxx"])
    }
    
    func setupSocket () {
        
    }
    
    func disconnect() {
        socket.disconnect()
    }
}
