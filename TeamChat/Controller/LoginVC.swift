//
//  LoginVC.swift
//  TeamChat
//
//  Created by YouSS on 10/1/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        guard let email = usernameTxt.text, email != "" else { return }
        guard let password = passwordTxt.text, password != "" else { return }
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.performSegue(withIdentifier: CHAT_UNWIND, sender: nil)
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGED, object: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func createAccPressed(_ sender: Any) {
        self.performSegue(withIdentifier: TO_CREATE_ACC, sender: nil)
    }
    
    func setupView() {
        spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor : purplePlaceHolder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : purplePlaceHolder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        self.view.endEditing(true)
    }
}
