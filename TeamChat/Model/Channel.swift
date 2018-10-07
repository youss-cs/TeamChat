//
//  Channel.swift
//  TeamChat
//
//  Created by YouSS on 10/7/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import Foundation

class Channel {
    public private(set) var id: String?
    public private(set) var title: String?
    public private(set) var description: String?
    
    init(id: String, title: String, desc: String) {
        self.id = id
        self.title = title
        self.description = desc
    }
}
