//
//  RoundedButton.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/25/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import UIKit
@IBDesignable

class RoundedButton: UIButton {

    // show in attribute inspecter
    
    @IBInspectable var cornerRadius:CGFloat = 3.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    
    
    
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }
    
    
    
    
    
    
}
