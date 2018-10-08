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
    var selectedChannel: Channel?
    
    func getchannels(completion: @escaping CompletionHandler) {
        Alamofire.request(GET_CHANNELS_URL, method: .get, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.result.value else { return }
                if let json = JSON(data).array {
                    for item in json {
                        let id = item["email"].stringValue
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
    
    func clearChannel() {
        channels.removeAll()
    }
}
