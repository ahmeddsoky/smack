//
//  CricleImage.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/26/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import UIKit
@IBDesignable

class CricleImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    
    
    func setUpView(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
    
    
    


}
