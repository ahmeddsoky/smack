//
//  UserDataService.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/25/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import Foundation

class UserDataService{
    
    // controlle class instance
    static let instance = UserDataService()
    
    //pubil to call var eith any class
    // privet don't mack change to var
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    // set user data
    func setUserData(id:String, color:String, avatarName:String, email:String, name:String){
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    // set AvatarName
    func setAvatarName(avatarName:String){
        self.avatarName = avatarName
    }
    
    // return avatar color to channelVC
    
    func returnUIColor(components: String) -> UIColor{
        // scan string color
        let scanner = Scanner(string: components)
        // skipped(تخطي)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        // var color
        var r,g,b,a : NSString?
        // scan color
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        // defaultColor
        let defaultColor = UIColor.lightGray
        //Unwrapped
        guard let rUnwrapped = r else { return defaultColor }
        guard let gUnwrapped = g else { return defaultColor }
        guard let bUnwrapped = b else { return defaultColor }
        guard let aUnwrapped = a else { return defaultColor }
        // cgflot
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        // newColor
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
      return newUIColor 
    }
    
    
    
    
    
    
    
    
    
}
