//
//  LoginVC.swift
//  TeamChat
//
//  Created by YouSS on 10/1/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccPressed(_ sender: Any) {
        self.performSegue(withIdentifier: TO_CREATE_ACC, sender: nil)
    }
}
