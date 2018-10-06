//
//  AvatarPickerVC.swift
//  TeamChat
//
//  Created by YouSS on 10/4/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        avatarType = segmentControl.selectedSegmentIndex == 0 ? AvatarType.dark : AvatarType.light
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        return AvatarCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 27
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numOfRows: CGFloat = 3
        
        if UIScreen.main.bounds.width > 320 {
            numOfRows = 4
        }
        
        let padding: CGFloat = 40
        let spaceBetweenCell: CGFloat = 10
        
        let dimensionCell = ((collectionView.bounds.width - padding) - (numOfRows - 1) * spaceBetweenCell) / numOfRows
        
        return CGSize(width: dimensionCell, height: dimensionCell)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let avatarName = (avatarType == AvatarType.dark) ? "dark\(indexPath.row)" : "light\(indexPath.row)"
        UserDataService.instance.setUserData(avatarName: avatarName)
        self.performSegue(withIdentifier: "createAccountUnwind", sender: nil)
    }

}
