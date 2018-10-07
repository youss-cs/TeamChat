//
//  ProfileVC.swift
//  TeamChat
//
//  Created by YouSS on 10/7/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGED, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        userName.text =  UserDataService.instance.name
        userEmail.text =  UserDataService.instance.email
        avatarImg.image = UIImage(named: UserDataService.instance.avatarName)
        avatarImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
    }
    
}
