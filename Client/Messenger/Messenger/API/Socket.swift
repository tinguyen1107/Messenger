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
    
    var closureListUserChange: (()->(Void))?

    init(url: String) {
        print("try to connrct")
        manager = SocketManager(socketURL: URL(string: url)!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        handleInit()
    }

    func isConnected (complete: @escaping ()->()) {
        print("let check")

        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            
            complete()
        }
    }

    func connect (data: Dictionary<String, String>) {
        socket.connect(withPayload: data)
    }

    func setupSocket () {

    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    func handleInit () {
        socket.on("session") { data, ack  in
            if let name = data[0] as? NSDictionary {
                print("** DATA **")
                Default.user.userID = name["userID"] as! String
                Default.user.sessionID = name["sessionID"] as! String
            }
        }
        
        socket.on("users") { data, ack  in
            print("** USER ** \n\(data)\n")
            if let final = data[0] as? [NSDictionary] {
                Default.listFriend.removeAll()
                for data in final {
                    Default.listFriend.append(friend(userID: data["userID"] as! String, username: data["username"] as! String, connect: data["connected"] as! Bool))
                }
                self.closureListUserChange?()
            }
        }
        
        socket.on("user connected") { data, ack in
            if let final = data[0] as? NSDictionary {
                Default.listFriend.append(friend(userID: final["userID"] as! String, username: final["username"] as! String, connect: final["connected"] as! Bool))
            }
            self.closureListUserChange?()
        }
        
        socket.on("user disconnected") { data, ack in
            if let final = data[0] as? String {
                for user in Default.listFriend {
                    if user.userID == final {
                        user.connect = false
                        self.closureListUserChange?()
                    }
                }
            }
        }
        
    }
    
    
}
