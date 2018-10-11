//
//  MessageService.swift
//  TeamChat
//
//  Created by YouSS on 10/7/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()

    var channels = [Channel]()
    var messages = [Message]()
    var unreadChannels = [String]()
    var selectedChannel: Channel?
    
    func getchannels(completion: @escaping CompletionHandler) {
        Alamofire.request(GET_CHANNELS_URL, method: .get, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.result.value else { return }
                if let json = JSON(data).array {
                    for item in json {
                        let id = item["_id"].stringValue
                        let title = item["name"].stringValue
                        let desc = item["description"].stringValue
                        let channel = Channel(id: id, title: title, desc: desc)
                        self.channels.append(channel)
                        completion(true)
                    }
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findAllMessageForChannel(channelId: String, completion: @escaping CompletionHandler) {
        print("\(GET_MESSAGES_URL)\(channelId)")
        Alamofire.request("\(GET_MESSAGES_URL)\(channelId)", method: .get, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.result.value else { return }
                if let json = JSON(data).array {
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                    print("Messages: \(self.messages)")
                    completion(true)
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func clearMessages() {
        messages.removeAll()
    }
    
    func clearChannel() {
        channels.removeAll()
    }
}
