//
//  ChannelVC.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/24/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDataSource,UITableViewDelegate {
    // outlet
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CricleImage!
    @IBOutlet weak var tableView: UITableView!
    // segue unwind
    @IBAction func prepareForUnwined(segue:UIStoryboardSegue){}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // size of channel
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        //Notfication
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        tableView.dataSource = self
        tableView.delegate = self
        // obesrver channel
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelLoaded(_:)), name: NOTIF_CHANNEL_LOADED, object: nil)
        // channel
        SocketService.instance.getChannel { (success) in
            if success{
                self.tableView.reloadData()
            }
        }
        // message
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId != MessageService.instance.selectChannel?.id && AuthService.instance.isLoggedIn{
                MessageService.instance.unreadChannels.append(newMessage.channelId)
                self.tableView.reloadData()
            }
        }
        
    }

    
    // to show data
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    // action
    
    // segue to login
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    // selector
    
    // notif User Data Did Change
    @objc func userDataDidChange(_ notif:Notification){
       setupUserInfo()
    }
    
    @objc func channelLoaded(_ notif:Notification){
        tableView.reloadData()
    }
    
    
    
    
    func setupUserInfo(){
        if AuthService.instance.isLoggedIn{
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named:UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        }else{
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named:"menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            tableView.reloadData()
        }
    }
    
    // tubleView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell{
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configuerCell(channel: channel)
            return cell
        }else{
        return UITableViewCell()
    }
    }
    
    // add channel
    @IBAction func addChannelBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
        //  instanse
        let addChannel = AddChannelVC()
        //modal
        addChannel.modalPresentationStyle = .custom
        // show
        present(addChannel, animated: true, completion: nil)
        }
        
    }
    
    // table View did select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectChannel = channel
        // filter Channel
        if MessageService.instance.unreadChannels.count > 0 {
            MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{$0 != channel.id}
        }
        let index = IndexPath(row: indexPath.row, section: 0)
        tableView.reloadRows(at: [index], with:.none)
        tableView.selectRow(at: index, animated: false, scrollPosition: .none)
        
        
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        // close menu after select
        self.revealViewController().revealToggle(animated: true)
    }
    
    
    
  

}
