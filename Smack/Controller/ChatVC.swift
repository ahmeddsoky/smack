//
//  ChatVC.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/24/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    // outlet
    @IBOutlet weak var menuBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // menu Btn add action to open Channel
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        // swipe to open channel(view)
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        // tap to close channel(view)
        view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
       
    }


}
