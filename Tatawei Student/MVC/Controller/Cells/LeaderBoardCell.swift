//
//  LeaderBoardCell.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 06/11/2024.
//

import UIKit

class LeaderBoardCell: UITableViewCell {

    @IBOutlet weak var numberingLabel: UILabel!
    @IBOutlet weak var studentHours: UILabel!
    @IBOutlet weak var iconGender: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var iconTopThree: UIImageView!
    
    
    
    func config(numbering: Int, hours: Int, genderIcon: UIImage, name: String, topThree: UIImage){
        numberingLabel.text = "\(numbering)"
        studentHours.text = "\(hours)"
        iconGender.image = genderIcon
        studentName.text = name
        iconTopThree.image = topThree
        
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
