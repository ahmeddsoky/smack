//
//  ProfileVC.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/27/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    // outlet
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
       
    }
    // action
    
    @IBAction func logoutPressed(_ sender: Any) {
         UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // back button
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setUpView(){
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImg.image = UIImage(named:UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UIGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
     
    }
    
    @objc func closeTap(_ recognizer:UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    

 
}
