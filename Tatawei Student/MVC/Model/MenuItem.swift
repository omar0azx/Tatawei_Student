//
//  MenuItem.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 01/04/1446 AH.
//

import UIKit

enum MenuItemType: String {
    case changeLanguage = "تغيير اللغة"
    case about = "عن تطوعي"
    case resetPassword = "تغيير كلمة المرور"
    case deleteAccount = "خذف الحساب"
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

