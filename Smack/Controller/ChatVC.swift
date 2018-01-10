//
//  ChatVC.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/24/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // outlet
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTxtBox: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var typingUserLbl: UILabel!
    
    
    // variables
    var isTyping = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // menu Btn add action to open Channel
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        // swipe to open channel(view)
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        // tap to close channel(view)
        view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        // add observer to get channel
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        // add observer when select channel
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        // find user by email
        if AuthService.instance.isLoggedIn{
           AuthService.instance.findUserByEmail(complection: { (sucess) in
               NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
      // keboard
        view.bindToKeyboard()
        // hidden Keaboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handelTap(_:)))
        view.addGestureRecognizer(tap)
        
        //table view
       tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // sendBtn
        sendBtn.isHidden = true
    }
    
    // selector
    @objc func userDataDidChange(_ notif:Notification){
        
        if AuthService.instance.isLoggedIn{
            // get Channel
            onLoginGetMessage()
            
        }else{
            channelNameLbl.text = "Please Log In"
            tableView.reloadData()
        }
    }
    // keboard
    @objc func handelTap(_ recognizer:UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    
    
    
    
    // channel selector
    @objc func channelSelected(_ notif:Notification) {
        // what happend when select channel
        updatWithChannel()
    }
    // what happend when select channel
    func updatWithChannel(){
        // change label
        let channelName = MessageService.instance.selectChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
        getMessage()
    }
    
    // get Channel
    func onLoginGetMessage() {
        MessageService.instance.findAllChannel { (success) in
            if success{
                // do stuff with channels
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectChannel = MessageService.instance.channels[0]
                    self.updatWithChannel()
                }else {
                    self.channelNameLbl.text = "No Channels Yet!!"
                }
            }
        }
    }
    
    
    // func get message
    func getMessage(){
        guard let channelId = MessageService.instance.selectChannel?.id else { return }
        MessageService.instance.findAllMessageForChannel(channelId: channelId) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    // action
    // send message
    @IBAction func sendMessage(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            guard let channelId = MessageService.instance.selectChannel?.id else { return }
            guard let message = messageTxtBox.text, messageTxtBox.text != "" else { return}
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageTxtBox.text = ""
                    self.messageTxtBox.resignFirstResponder()
                     SocketService.instance.socket.defaultSocket.emit("stopType", UserDataService.instance.name, channelId)
                }
            })
        }
        
        // chat message
//        SocketService.instance.getChatMessage { (success) in
//            if success {
//                self.tableView.reloadData()
//                if MessageService.instance.messages.count > 0 {
//                    let indIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
//                    self.tableView.scrollToRow(at: indIndex, at: .bottom, animated: false)
//                }
//            }
//        }
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId == MessageService.instance.selectChannel?.id && AuthService.instance.isLoggedIn{
                MessageService.instance.messages.append(newMessage)
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1 , section: 0)
                    self.tableView.scrollToRow(at: endIndex, at:.bottom , animated: false)
                    
                }
            }
        }
        
        
        
        
        
        
        
        
        // typing user
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectChannel?.id else { return }
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser , channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    }else{
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingUserLbl.text = "\(names)\(verb) typing a message"
            }else{
                self.typingUserLbl.text = ""
            }
        }
    }
    
     // tableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell{
            let message = MessageService.instance.messages[indexPath.row]
            cell.configuerCell(message: message)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    // text file editing change
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        //typing
        guard let channelId = MessageService.instance.selectChannel?.id else { return }
        
        if messageTxtBox.text == ""{
            isTyping = false
            sendBtn.isHidden = true
            //typing
            SocketService.instance.socket.defaultSocket.emit("stopType", UserDataService.instance.name, channelId)
        }else{
            if isTyping == false {
                sendBtn.isHidden = false
                //typing
                SocketService.instance.socket.defaultSocket.emit("startType", UserDataService.instance.name, channelId)
            }
            isTyping = true
        }
    }
    
    
    
    
    
    
    
    
    
    
    
   
}


