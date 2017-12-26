//
//  AvatarCell.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/26/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import UIKit
enum AvatarType{
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    
    // outlet
    @IBOutlet weak var avatarImg: UIImageView!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    // configuer avatarCell
    func configuerCell(index:Int,type:AvatarType){
        if type == AvatarType.dark{
            avatarImg.image = UIImage(named:"dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }else{
            avatarImg.image = UIImage(named:"light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func setUpView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}




