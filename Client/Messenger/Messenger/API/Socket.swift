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
    var closureListMessageChange: ((Message)->(Void))?

    init(url: String) {
        manager = SocketManager(socketURL: URL(string: url)!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        handleInit()
    }
    
    func connect (data: Dictionary<String, String>) {
        socket.connect(withPayload: data)
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    func handleInit () {
        socket.on("list_users_in_database", callback: { data, ack in
            print("** DATA **")
            print (data)
            if let listUser = data[0] as? [[String]] {
                listUser.forEach({
                    Default.listFriend.append(User(email: $0[2], password: nil, _id: $0[0], fullname: $0[1]))
                })
                self.closureListUserChange?()
            }
        })
        
        socket.on("user_connected") { data, ack in
            print(data)
            if let user = data[0] as? Dictionary<String, String> {
                Default.listFriend.append(User(email: user["email"], password: nil, _id: user["_id"], fullname: user["fullname"]))
            }
        }
        
        socket.on("send_messsage") { data, ack in
            print(data)
            
            let final = try! JSONSerialization.data(withJSONObject: data[0])
            let message = try! JSONDecoder().decode(Message.self, from: final)
            
            Default.listMessage.append(message)
            self.closureListMessageChange?(message)
        }
////                Default.user.userID = name["userID"] as! String
////                Default.user.sessionID = name["sessionID"] as! String
//            }
//        }
        
//        socket.on("users") { data, ack  in
//            print("** USER ** \n\(data)\n")
//            if let final = data[0] as? [NSDictionary] {
//                Default.listFriend.removeAll()
//                for data in final {
//                    Default.listFriend.append(friend(userID: data["userID"] as! String, username: data["username"] as! String, connect: data["connected"] as! Bool))
//                }
//                self.closureListUserChange?()
//            }
//        }
        
//        socket.on("user connected") { data, ack in
//            if let final = data[0] as? NSDictionary {
//                Default.listFriend.append(friend(userID: final["userID"] as! String, username: final["username"] as! String, connect: final["connected"] as! Bool))
//            }
//            self.closureListUserChange?()
//        }
        
//        socket.on("user disconnected") { data, ack in
//            if let final = data[0] as? String {
//                for user in Default.listFriend {
//                    if user.userID == final {
//                        user.connect = false
//                        self.closureListUserChange?()
//                    }
//                }
//            }
//        }
    }
}
