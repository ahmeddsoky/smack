//
//  LoginVC.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/25/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    
    
    

}
