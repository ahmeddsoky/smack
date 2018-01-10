//
//  Constants.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/24/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import Foundation
typealias ComplectionHandler = (_ success:Bool) -> ()



// segue
let TO_LOGIN = "tologin"
let TO_CREATEACCOUNT = "tocreataccount"
let UNWIND = "unwinedSegue"
let TO_AVATAR_PICKER = "toAvatar"

// user default
let LOGEED_IN_KEY = "loggedIn"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"


// URL
let BASE_URL = "https://newsmack.herokuapp.com/V1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNEL = "\(BASE_URL)channel/"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel/"



// header
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

let BEARER_HEADER = [
            "Authorization":"Bearer \(AuthService.instance.authToken)",
            "Content-Type": "application/json; charset=utf-8"
]

// placeHolderColor
let smackPurpulPlaceholder = #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)


// Notifcation
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChange")
let NOTIF_CHANNEL_LOADED = Notification.Name("channelLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("channelSelected")








