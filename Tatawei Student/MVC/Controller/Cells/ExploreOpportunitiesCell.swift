//
//  ExploreOpportunitiesCell.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 14/04/1446 AH.
//

import UIKit

class ExploreOpportunitiesCell: UICollectionViewCell {
    
    @IBOutlet weak var opportunityView: UIView!
    @IBOutlet weak var opportunityImage: UIImageView!
    @IBOutlet weak var opportunityName: UILabel!
    @IBOutlet weak var opportunityTime: UILabel!
    @IBOutlet weak var opportunityHours: UILabel!
    @IBOutlet weak var opportunityCity: UILabel!
    
    @IBOutlet weak var organizationImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configOpportunity(backgroundColor: UIColor, opportunityImage: UIImage, opportunityName: String, opportunityTime: String, opportunityHours: Int, opportunityCity: String, organizationImage: UIImage){
        
        opportunityView.backgroundColor = backgroundColor
        self.opportunityImage.image = opportunityImage
        self.opportunityName.text = opportunityName
        self.opportunityHours.text = "\(opportunityHours) Hours"
        self.opportunityTime.text = opportunityTime
        self.opportunityCity.text = opportunityCity
        self.organizationImage.image = organizationImage
        
    }

}
