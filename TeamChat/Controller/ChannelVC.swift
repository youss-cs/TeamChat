//
//  ChannelVC.swift
//  TeamChat
//
//  Created by YouSS on 9/30/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.userDataDidChanged(_:)), name: NOTIF_USER_DATA_DID_CHANGED, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserData()
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @objc func userDataDidChanged(_ notif: Notification) {
        setupUserData()
    }
    
    func setupUserData() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "profileDefault")
            userImg.backgroundColor = UIColor.clear
        }
    }

}
