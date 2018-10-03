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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ChooseAvatarPressed(_ sender: Any) {
    }
    
    @IBAction func generateBGColorPressed(_ sender: Any) {
    }
    
    @IBAction func createAccPressed(_ sender: Any) {
        guard let email = emailTxt.text, email != "" else { return }
        guard let password = passwordTxt.text, email != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { (sucess) in
                    if success {
                        //
                    }
                })
            }
        }
    }
    
    

}
