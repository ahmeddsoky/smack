//
//  MessageCell.swift
//  Smack
//
//  Created by Ahmed Dsoky on 1/8/18.
//  Copyright © 2018 Ahmed Dsoky. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    
    // outlets
    @IBOutlet weak var userImage: CricleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // func ConfiguerCell
    func configuerCell(message:Message){
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
        userImage.image = UIImage(named:message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }
    
    
    
    
    
    
    
    
    

}
