//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Ahmed Dsoky on 12/26/17.
//  Copyright © 2017 Ahmed Dsoky. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    //outlet
    @IBOutlet weak var CollectionView: UICollectionView!
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    // varaible
    var avatarType = AvatarType.dark
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.dataSource = self
        CollectionView.delegate = self
        
    }
    
    
    
    // collection view function
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell{
            cell.configuerCell(index: indexPath.item, type: avatarType)
            return cell
        }
            return AvatarCell()
        
    }
    
    
    
    
// action
    // back avtar Btn
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // chose dark or light
    @IBAction func segmentedControllerPressed(_ sender: Any) {
        if segmentController.selectedSegmentIndex == 0 {
            avatarType = .dark
        }else{
            avatarType = .light
        }
        CollectionView.reloadData()
    }
    
    // drow size of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // number Of Cloumns
        var numOfCloumns:CGFloat = 3
        if UIScreen.main.bounds.width > 320{
            numOfCloumns = 4
        }
        // space Btween Cell
        let spaceBtweevCell:CGFloat = 10
        // padding
        let padding:CGFloat = 40
        // cellDimension
        let cellDimension:CGFloat = ((collectionView.bounds.width - padding) - (numOfCloumns - 1 ) * spaceBtweevCell) / numOfCloumns
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    
    // to select avatar
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark{
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
            
        }else{
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
