//
//  QuestionCell.swift
//  Tatawei Student
//
//  Created by testuser on 03/05/1446 AH.
//

import UIKit

class QuestionCell: UITableViewCell {

    
    @IBOutlet weak var titleCell: UILabel!
    
    @IBOutlet weak var contentCell: UILabel!
    
    @IBOutlet weak var chervronImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
