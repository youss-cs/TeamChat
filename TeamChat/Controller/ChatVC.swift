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
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGED, object: nil)
                }
            })
        }
        
        MessageService.instance.getchannels { (success) in }
    }
    
    @IBAction func chatUnwind(_ segue: UIStoryboardSegue) { }

}
