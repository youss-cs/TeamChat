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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    @IBAction func createAccountUnwind(_ segue: UIStoryboardSegue) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    @IBAction func ChooseAvatarPressed(_ sender: Any) {
        self.performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func generateBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(displayP3Red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r), \(g), \(b), 1]"
        
        UIView.animate(withDuration: 0.2) {
            self.userImg.backgroundColor = self.bgColor
        }
    }
    
    @IBAction func createAccPressed(_ sender: Any) {
        guard let name = usernameTxt.text, name != "" else { return }
        guard let email = emailTxt.text, email != "" else { return }
        guard let password = passwordTxt.text, email != "" else { return }
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { (sucess) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: CHAT_UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGED, object: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    func setupView() {
        spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor : purplePlaceHolder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : purplePlaceHolder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : purplePlaceHolder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        self.view.endEditing(true)
    }

}
