//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/25/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    // outlet
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emaileTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // varaible
    var avataName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor:UIColor?
    
    // to show avatar
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avataName = UserDataService.instance.avatarName
            if avataName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
       
    }
// action
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        // spinner
        spinner.isHidden = false
        spinner.startAnimating()
        // tack data from txtFiled
        guard let name = userNameTxt.text, userNameTxt.text != "" else { return }
        guard let email = emaileTxt.text, emaileTxt.text != "" else { return }
        guard let pass = passTxt.text, passTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success{
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avataName, avatarColor: self.avatarColor, completion: { (success) in
                            if success{
                                // spinner
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                // dismiss
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                // Notifcation
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                })
            }
        }
        
        
        
        
        
        
    }
    
    // chose avatar
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    
    
    // chose Color
    @IBAction func pickBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255))/255
        let g = CGFloat(arc4random_uniform(255))/255
        let b = CGFloat(arc4random_uniform(255))/255
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r), \(g), \(b), 1]"
        UIView.animate(withDuration: 0.2){
        self.userImg.backgroundColor = self.bgColor
        }
    }
    
// segue to channelVc
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    // change color PlaceHolder
    
    func setUpView(){
        
        // color placeHolder
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "userName", attributes: [NSAttributedStringKey.foregroundColor:smackPurpulPlaceholder])
        emaileTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor:smackPurpulPlaceholder])
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor:smackPurpulPlaceholder])
        
        // end keaboard
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handelTap(_recognizer:)))
        view.addGestureRecognizer(tap)
        
        // spinner
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
      
    }
    
    @objc func handelTap(_recognizer:UITapGestureRecognizer){
        self.view.endEditing(true)
    }

    
    
    
    
    
    
    
    
    


}
