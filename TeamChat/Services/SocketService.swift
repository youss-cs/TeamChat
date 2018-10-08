//
//  SocketService.swift
//  TeamChat
//
//  Created by YouSS on 10/8/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    
    private var manager: SocketManager
    private var socket: SocketIOClient
    
    override init() {
        manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
        socket = manager.defaultSocket
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addChannel(name: String, description: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", name, description)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let title = dataArray[0] as? String else { return }
            guard let desc = dataArray[1] as? String else { return }
            guard let id = dataArray[2] as? String else { return }
            
            let channel = Channel(id: id, title: title, desc: desc)
            MessageService.instance.channels.append(channel)
            completion(true)
        }
        
    }

}
