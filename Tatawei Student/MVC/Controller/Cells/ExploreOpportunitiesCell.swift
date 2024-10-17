//
//  ExploreOpportunitiesCell.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 14/04/1446 AH.
//

import UIKit

class ExploreOpportunitiesCell: UICollectionViewCell {
    
    @IBOutlet weak var oppView: UIView!
    
    @IBOutlet weak var oppImage: UIImageView!
    
    @IBOutlet weak var oppName: UILabel!
    
    @IBOutlet weak var oppTime: UILabel!
    
    @IBOutlet weak var oppHours: UILabel!
    
    @IBOutlet weak var organizationIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configOppt(backgroundColor: UIColor, orgaImage: UIImage, oppImage: UIImage, opptName: String, opptTime: String, opptHours: Int){
        
        oppView.backgroundColor = backgroundColor
        organizationIcon.image = orgaImage
        self.oppImage.image = oppImage
        oppName.text = opptName
        oppHours.text = "\(opptHours) Hours"
        oppTime.text = opptTime
        
    }

}
