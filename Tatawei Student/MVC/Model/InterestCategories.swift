//
//  InterestCategories.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 23/03/1446 AH.
//

import UIKit

enum InterestCategories: String, Codable {
    case Sports = "رياضة"
    case Technical = "تقنية"
    case Cultural = "ثقافة"
    case Financial = "مالية"
    case Tourism = "سياحة"
    case Social = "اجتماعية"
}

struct opportunities {
    var name: String
    var date: String
    var organizationIcon: UIImage
    var opportunityHours: Int
    var accecptanceStatus: Bool
    var opportunityIcon: UIImage
    var BGColor: UIColor
    var time: String
    
}
