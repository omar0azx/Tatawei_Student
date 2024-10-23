//
//  FiltrationCell.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 16/04/1446 AH.
//

import UIKit

class FiltrationCell: UICollectionViewCell {

    @IBOutlet weak var interstView: UIView!
    
    @IBOutlet weak var interstLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(type: String, color: UIColor) {
        interstLabel.text = type
        interstView.backgroundColor = color
    }
    
}
