//
//  SocketService.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/29/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import UIKit
import SocketIO


class SocketService: NSObject {
    // instance
    static let instance = SocketService()
    // init
    override init() {
        super.init()
    }
    // create socket
    var socket:SocketManager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true),.compress])
    
    // establishConnection
    func establishConnection(){
        socket.defaultSocket.connect()
    }
    
    // closeConnection
    func closeConnection(){
        socket.defaultSocket.disconnect()
    }
    
    // add channel
    func addChannel(channelName:String, channelDescription:String, completion:@escaping ComplectionHandler){
        
        socket.defaultSocket.emit("newChannel", channelName,channelDescription)
        completion(true)
        
    }
    
    // get channel
    func getChannel(completion: @escaping  ComplectionHandler){
        socket.defaultSocket.on("channelCreated") { (dataArray, ack) in
            
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDescription, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    
    //func add Message
    func addMessage(messageBody:String, userId:String, channelId:String, completion:@escaping ComplectionHandler){
        
        // user
        let user = UserDataService.instance
        // socket
        socket.defaultSocket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor )
        completion(true)  
    }
    

    // get chate message
    func getChatMessage(completion: @escaping (_ newMessage:Message) -> Void) {
        socket.defaultSocket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
//            //check
//            if channelId == MessageService.instance.selectChannel?.id && AuthService.instance.isLoggedIn{
//
//
//                MessageService.instance.messages.append(newMessage)
//                completion(true)
//            }else {
//                completion(false)
            
            
            completion(newMessage)
            
        }
    }
    
    // listning typing user
    // use to show user typing
    
    func getTypingUsers(_ completionHandler : @escaping (_ typingUsers : [String:String]) -> Void) {
        
        socket.defaultSocket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String:String] else { return }
            completionHandler(typingUsers)
        }
    }
    
    
    

    
    
    
    
    
    
    
}
