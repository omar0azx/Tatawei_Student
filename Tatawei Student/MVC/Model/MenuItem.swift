//
//  MenuItem.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 01/04/1446 AH.
//

import UIKit

enum MenuItemType: String {
    case termsAndConditions = "الشروط والأحكام"
    case about = "عن تطوعي"
    case resetPassword = "تغيير كلمة المرور"
    case deleteAccount = "حذف الحساب"
    case logout = "تسجيل الخروج"
}

struct MenuItem {
     let image: UIImage
     let label: MenuItemType
    init(image: UIImage, label: MenuItemType) {
        self.image = image
        self.label = label
    }
}
