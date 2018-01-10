//
//  AddChannelVC.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/29/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    // outlet
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var chanDesc: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setUpView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // action
    
    @IBAction func closeModelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func CreateChannelPressed(_ sender: Any) {
        guard let channelName = nameTxt.text, nameTxt.text != "" else { return }
        guard let channelDescription = chanDesc.text, chanDesc.text != "" else { return }
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
            if success {
               self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    // func setUpView
    func setUpView(){
        // textFiledColor
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor:smackPurpulPlaceholder])
        chanDesc.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor:smackPurpulPlaceholder])
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        
        
    }
    
    @objc func closeTap(_ recoginzer:UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    

 

}
