//
//  InterestsCell.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 26/03/1446 AH.
//

import UIKit

class InterestsCell: UICollectionViewCell {
    
    @IBOutlet weak var interstView: DesignableView!
    
    @IBOutlet weak var interstLabel: UILabel!
    
    func config(type: String, color: UIColor) {
        interstLabel.text = type
        interstView.backgroundColor = color
    }
    
}
