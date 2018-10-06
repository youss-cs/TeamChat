//
//  CreateAccountVC.swift
//  TeamChat
//
//  Created by YouSS on 10/2/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    var avatarName = "profileDefault"
    let avatarColor = "[0.5,0.5,0.5,1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccountUnwind(_ segue: UIStoryboardSegue) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
    }
    
    @IBAction func ChooseAvatarPressed(_ sender: Any) {
        self.performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func generateBGColorPressed(_ sender: Any) {
    }
    
    @IBAction func createAccPressed(_ sender: Any) {
        guard let name = usernameTxt.text, name != "" else { return }
        guard let email = emailTxt.text, email != "" else { return }
        guard let password = passwordTxt.text, email != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { (sucess) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print("User added!!")
                                self.performSegue(withIdentifier: CHANNEL_UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    

}
