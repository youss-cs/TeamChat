//
//  AddChannelVC.swift
//  TeamChat
//
//  Created by YouSS on 10/8/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }


    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let name = usernameTxt.text, name != "" else { return }
        guard let desc = descTxt.text, desc != "" else { return }
        
        SocketService.instance.addChannel(name: name, description: desc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func setupView() {
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor : purplePlaceHolder])
        descTxt.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor : purplePlaceHolder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        bgView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
