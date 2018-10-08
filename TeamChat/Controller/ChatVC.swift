//
//  ChatVC.swift
//  TeamChat
//
//  Created by YouSS on 9/30/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import UIKit
import SideMenu

class ChatVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuWidth = self.view.bounds.width - 40
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.userDataDidChanged(_:)), name: NOTIF_USER_DATA_DID_CHANGED, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGED, object: nil)
                }
            })
        }
    }
    
    @IBAction func chatUnwind(_ segue: UIStoryboardSegue) { }
    
    @objc func userDataDidChanged(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            title = "Please Log In."
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateTitle()
    }
    
    func onLoginGetMessages() {
        MessageService.instance.getchannels { (success) in }
    }
    
    func updateTitle() {
        let name = MessageService.instance.selectedChannel?.title ?? ""
        self.title = "#\(name)"
    }

}
