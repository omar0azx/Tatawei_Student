//
//  OpportunitiesCell.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 05/10/2024.
//

import UIKit
import SwiftUICore

class OpportunitiesCell: UICollectionViewCell {
    
    
    @IBOutlet weak var BGView: CustomBackgroundView!
    @IBOutlet weak var pointView: DesignableView!
    @IBOutlet weak var organizationIcon: UIImageView!
    @IBOutlet weak var opptIcon: UIImageView!
    @IBOutlet weak var opptNameLbl: UILabel!
    @IBOutlet weak var opptHoursLBL: UILabel!
    @IBOutlet weak var opptTimeLbl: UILabel!
    @IBOutlet weak var colorOfStatus: UIView!
    @IBOutlet weak var accecptanceStatusLbl: UILabel!
    @IBOutlet weak var oppDate: UILabel!
    

    func configOppt(orgaIcon: UIImage, oppIcon: UIImage, opptName: String, opptTime: String, opptHours: Int, opptDate: String , backgroundColor: UIColor, status: Bool){
        
        BGView.fillColor = backgroundColor
        organizationIcon.image = orgaIcon
        opptIcon.image = oppIcon
        opptNameLbl.text = opptName
        opptHoursLBL.text = "\(opptHours) Hours"
        opptTimeLbl.text = opptTime
        oppDate.text = opptDate
        
        // Verify student acceptance into the opportunity
        if (status == true){
            colorOfStatus.backgroundColor = .green
            accecptanceStatusLbl.text = "مقبول"
        } else {
            colorOfStatus.backgroundColor = .orange
            accecptanceStatusLbl.text = "معلق"

        }
        
        
    }
}
