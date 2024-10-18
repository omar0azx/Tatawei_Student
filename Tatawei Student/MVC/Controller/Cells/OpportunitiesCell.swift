//
//  OpportunitiesCell.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 05/10/2024.
//

import UIKit
import SwiftUICore

class OpportunitiesCell: UICollectionViewCell {
    
    
    @IBOutlet weak var opportunityView: CustomBackgroundView!
    @IBOutlet weak var pointView: DesignableView!
    @IBOutlet weak var organizationIcon: UIImageView!
    @IBOutlet weak var opportunityImage: UIImageView!
    @IBOutlet weak var opportunityName: UILabel!
    @IBOutlet weak var opportunityDate: UILabel!
    @IBOutlet weak var opportunityTime: UILabel!
    @IBOutlet weak var opportunityHour: UILabel!
    @IBOutlet weak var accecptanceMessage: UILabel!
    @IBOutlet weak var statusView: UIView!

    func configOpportunity(backgroundColor: UIColor, opportunityImage: UIImage, opportunityName: String, opportunityTime: String, opportunityHour: Int, opportunityDate: String, organizationImage: UIImage, status: Bool) {
        
        opportunityView.fillColor = backgroundColor
        self.opportunityImage.image = opportunityImage
        self.opportunityName.text = opportunityName
        self.opportunityTime.text = opportunityTime
        self.opportunityHour.text = "\(opportunityHour) Hours"
        self.opportunityDate.text = opportunityDate
        organizationIcon.image = organizationImage
        
        // Verify student acceptance into the opportunity
        if (status == true){
            statusView.backgroundColor = .green
            accecptanceMessage.text = "مقبول"
        } else {
            statusView.backgroundColor = .orange
            accecptanceMessage.text = "معلق"

        }
        
        
    }
}
