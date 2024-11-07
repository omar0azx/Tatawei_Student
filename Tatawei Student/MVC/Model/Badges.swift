//
//  Badges.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 05/11/2024.
//

import Foundation
import UIKit

//MARK: - Badges for hourse opportunity

struct Badge {
    let name: String
    let image: UIImage
}

let hoursBadges: [Badge] = [
    Badge(name: "بطل", image: UIImage(named: "strongImage")!),
    Badge(name: "قوي", image: UIImage(named: "strongImage")!),
    Badge(name: "ذكي", image: UIImage(named: "strongImage")!),
    Badge(name: "محنك", image: UIImage(named: "strongImage")!),
    Badge(name: "ذيبان", image: UIImage(named: "strongImage")!)
]


var houresBadgesOfStudent: [Badge] {
    var badges = [Badge]()
    guard let student = Student.currentStudent else {
        print("لم يتم العثور على طالب حالي.")
        return badges // Return an empty array if no current student
    }


    if student.hoursCompleted >= 40 {
        badges.append(hoursBadges[3])
    }
    if student.hoursCompleted >= 30 {
        badges.append(hoursBadges[2])
    }
    if student.hoursCompleted >= 15 {
        badges.append(hoursBadges[1])
    }
    if student.hoursCompleted >= 5 {
        badges.append(hoursBadges[0])

    }

    return badges
}



//MARK: - Badges for skill
struct SkillBadge {
    let badge: Badge
    var level: Int
}

var skillBadges: [SkillBadge] = [
    SkillBadge(badge: Badge(name: "مهاري", image:  UIImage(named: "strongImage")!), level: 5),
    SkillBadge(badge: Badge(name: "سريع", image:  UIImage(named: "strongImage")!), level: 5),
    SkillBadge(badge: Badge(name: "مراوغ", image:  UIImage(named: "strongImage")!), level: 5),
    SkillBadge(badge: Badge(name: "هداف", image:  UIImage(named: "strongImage")!), level: 5),
    SkillBadge(badge: Badge(name: "مدافع", image:  UIImage(named: "strongImage")!), level: 5)

]

let skillBadgesOfStudent: [SkillBadge] = skillBadges.filter { $0.level >= 5 }


let allBadgesForStudent: [Badge] = skillBadgesOfStudent.map { $0.badge } + houresBadgesOfStudent

