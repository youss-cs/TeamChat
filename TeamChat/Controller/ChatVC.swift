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
    }

}
