//
//  AuthService.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/25/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class AuthService{
    
    // instance to controll class
    static let instance = AuthService()
    // store memory
    let defaults = UserDefaults.standard
    
    // varaible use userdefault
    
    var isLoggedIn : Bool {
        
        get {
            return defaults.bool(forKey: LOGEED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGEED_IN_KEY )
        }
    }
    
    var authToken:String {
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail:String{
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    // register user api (Alamofire)
    
    func registerUser(email:String,password:String,completion:@escaping ComplectionHandler){
        
        // email
        let LowerCaseEmail = email.lowercased()
        // header
//        let header = [
//            "Content-Type": "application/json; charset=utf-8"
//        ]
        // body
        let body:[String:Any] = [
            "email":LowerCaseEmail,
            "password":password
        ]
        // request
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    // func loginUser
    
    func loginUser(email:String,password:String,completion:@escaping ComplectionHandler){
        // email
        let LowerCaseEmail = email.lowercased()
        // body
        let body:[String:Any] = [
            "email":LowerCaseEmail,
            "password":password
        ]
        // api login
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                // handel data parsing data || retrive data
               /* if let json = response.result.value as? Dictionary<String,Any>{
                    if let email = json["user"] as? String{
                        self.userEmail = email
                    }
                    if let token = json["token"] as? String{
                        self.authToken = token
                    }
                }*/
                // handel data parsing data || retrive data (swiftyJson)
                
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                completion(true)
                self.isLoggedIn = true
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
       
    }
    
    // cerate user
    
    func createUser(name:String, email:String, avatarName:String, avatarColor:String, completion:@escaping ComplectionHandler){
        // email
        let LowerCaseEmail = email.lowercased()
        //body
        let body:[String:Any] = [
            "name":name,
            "email":LowerCaseEmail,
            "avatarName":avatarName,
            "avatarColor":avatarColor

        ]
        // header
        let header = [
            "Authorization":"Bearer \(AuthService.instance.authToken)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        // api request
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
              // handel data parsing data || retrive data
                guard let data = response.data else { return }
                let json = try! JSON(data:data)
                let id = json["_id"].stringValue
                let color = json["avatarColor"].stringValue
                let avatarName = json["avatarName"].stringValue
                let email = json["email"].stringValue
                let name = json["name"].stringValue
                
                UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
                
               completion(true)
            }else{
               completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
