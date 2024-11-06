//
//  BadgesContentCell.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 05/11/2024.
//

import UIKit

class BadgesContentCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? houresBadgesOfStudent.count : skillBadgesOfStudent.count
    }
    
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     return CGSize(width: 128, height: 128)
 }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }



 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BadgesCell", for: indexPath) as! BadgesCell
    collectionView.semanticContentAttribute = .forceRightToLeft
     if collectionView.tag == 0 {
         let badge = houresBadgesOfStudent[indexPath.row]
         cell.config(name: badge.name, icon: badge.image)
     } else {
         let badge = skillBadgesOfStudent[indexPath.row]
         cell.config(name: badge.badge.name , icon: badge.badge.image ?? UIImage())
     }
     
     return cell
 }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
