//
//  BadgesCell.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 05/11/2024.
//

import UIKit

class BadgesCell: UICollectionViewCell {
    
    @IBOutlet weak var badgeIcon: UIImageView!
    @IBOutlet weak var badgeName: UILabel!
    
    func config(name: String, icon: UIImage){
        badgeIcon.image = icon
        badgeName.text = name
    }
}
