//
//  Constants.swift
//  TeamChat
//
//  Created by YouSS on 10/1/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import Foundation
import UIKit

typealias CompletionHandler = (_ Success: Bool) -> ()


//URLs
let BASE_URL = "https://ousyous.herokuapp.com/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"
let ADD_URL = "\(BASE_URL)user/add"
let USER_BY_EMAIL_URL = "\(BASE_URL)user/byEmail/"

//Colors
let purplePlaceHolder = #colorLiteral(red: 0.3647058824, green: 0.4039215686, blue: 0.8784313725, alpha: 0.5)

//Notifications
let NOTIF_USER_DATA_DID_CHANGED = Notification.Name("notifUserDataChanged")

//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACC = "toCreateAcc"
let CHAT_UNWIND = "chatUnwind"
let TO_AVATAR_PICKER = "toAvatarPicker"

//User defauls
let TOKEN_KEY = "token"
let IS_LOGGED_IN = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers
let HEADER = ["Content-Type": "application/json; charset=utf-8"]
let BEARER_HEADER = ["Authorization":"Bearer \(AuthService.instance.authToken)","Content-Type": "application/json; charset=utf-8"]
