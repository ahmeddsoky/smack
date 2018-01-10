//
//  LoginVC.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/25/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // outlet
    @IBOutlet weak var userEmailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // action
    
    // back to channelVC
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // segue to create accountVC
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATEACCOUNT, sender: nil)
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        // spinner
        spinner.isHidden = false
        spinner.startAnimating()
        // textfile
        guard let email = userEmailTxt.text, userEmailTxt.text != "" else { return }
        guard let pass = passwordTxt.text, passwordTxt.text != "" else { return }
        // login
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.findUserByEmail(complection: { (success) in
                    if success{
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
        
     
        
    }
    
    
    
    // func setUpView
    
    func setUpView(){
        // spinner
        spinner.isHidden = true
        // placeHolder
        userEmailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor:smackPurpulPlaceholder])

        passwordTxt.attributedPlaceholder = NSAttributedString(string: "passeord", attributes: [NSAttributedStringKey.foregroundColor:smackPurpulPlaceholder])
    }


    
    
    
    
    

}

