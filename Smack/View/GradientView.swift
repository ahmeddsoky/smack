//
//  GradientView.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/24/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import UIKit
@IBDesignable

class GradientView: UIView {
    
    // add Color to main story bord in attribute inspecter (two var)
    
    @IBInspectable var topColor:UIColor = #colorLiteral(red: 0.3647058824, green: 0.4039215686, blue: 0.8784313725, alpha: 1) {
        didSet{
            setNeedsLayout()
        }
    }
    
    
    @IBInspectable var bottomColor:UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet{
            setNeedsLayout()
        }
        
    }
    // to design layer
   override func layoutSubviews() {
        // instance gradient
    let gradientLayer = CAGradientLayer()
    // Chose Color
    gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor]
    // start point
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    // end point
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    // chose bounds
    gradientLayer.frame = self.bounds
    //insert gradient
    self.layer.insertSublayer(gradientLayer, at: 0)
    
    
    
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
