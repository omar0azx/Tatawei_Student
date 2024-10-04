//
//  SettingsCell.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 30/03/1446 AH.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
               // Custom code when cell is selected
               UIView.animate(withDuration: 0.1) {
                   self.contentView.backgroundColor = UIColor.systemGray4
               } completion: { e in
                   self.contentView.backgroundColor = UIColor.systemGray5
               }
           }
    }
    
    func configure(menuItem: MenuItem) {
            itemlabel.text = menuItem.label.rawValue
            self.itemImage.image = menuItem.image
        }

}
