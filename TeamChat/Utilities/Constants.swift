//
//  Constants.swift
//  TeamChat
//
//  Created by YouSS on 10/1/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()
let HEADER = ["Content-Type": "application/json; charset=utf-8"]

//URLs
let BASE_URL = "https://ousyous.herokuapp.com/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"

//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACC = "toCreateAcc"

//User defauls
let TOKEN_KEY = "token"
let IS_LOGGED_IN = "loggedIn"
let USER_EMAIL = "userEmail"
