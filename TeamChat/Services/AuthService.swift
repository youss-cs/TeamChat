//
//  AuthService.swift
//  TeamChat
//
//  Created by YouSS on 10/3/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: IS_LOGGED_IN)
        }
        
        set {
            defaults.set(self, forKey: IS_LOGGED_IN)
        }
    }
    
    var authToken : String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        
        set {
            defaults.set(self, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        
        set {
            defaults.set(self, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let body: [String : Any] = [
            "email" : email.lowercased(),
            "password" : password
        ]
        
        Alamofire.request(REGISTER_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let body: [String : Any] = [
            "email" : email.lowercased(),
            "password" : password
        ]
        
        Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.result.value else { return }
                let json = JSON(data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let body: [String : Any] = [
            "name" : name,
            "email" : email.lowercased(),
            "avatarName" : avatarName,
            "avatarColor" : avatarColor
        ]
        
        let header = ["Authorization":"Bearer \(AuthService.instance.authToken)","Content-Type": "application/json; charset=utf-8"]
        
        Alamofire.request(ADD_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.result.value else { return }
                let json = JSON(data)
                let email = json["user"].stringValue
                let name = json["name"].stringValue
                let avatarName = json["avatarName"].stringValue
                let avatarColor = json["avatarColor"].stringValue
                let id = json["_id"].stringValue
                UserDataService.instance.setUserData(id: id, avatarColor: avatarColor, avatarName: avatarName, email: email, name: name)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
}
