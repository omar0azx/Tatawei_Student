//
//  BadgesVC.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 05/11/2024.
//

import UIKit

class BadgesVC: UIViewController, Storyboarded {

    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    var hoursBadges = [Badge]()
    var skillsBadges = [Badge]()

    //MARK: - IBOutleats

    @IBOutlet weak var lastBadgeImage: UIImageView!
    @IBOutlet weak var lastBadgeName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let student = Student.currentStudent {
            if student.hoursCompleted >= 5 {
                let badgeName = HoursBadges.hero.rawValue
                hoursBadges.append(Badge(name: badgeName, image: UIImage(named: "\(badgeName)")!))
            }
            if student.hoursCompleted >= 10 {
                let badgeName = HoursBadges.legend.rawValue
                hoursBadges.append(Badge(name: badgeName, image: UIImage(named: "\(badgeName)")!))
            }
            if student.hoursCompleted >= 20 {
                let badgeName = HoursBadges.terrible.rawValue
                hoursBadges.append(Badge(name: badgeName, image: UIImage(named: "\(badgeName)")!))
            }
            if student.hoursCompleted >= 30 {
                let badgeName = HoursBadges.experienced.rawValue
                hoursBadges.append(Badge(name: badgeName, image: UIImage(named: "\(badgeName)")!))
            }
            if student.hoursCompleted >= 40 {
                let badgeName = HoursBadges.opportunityKiller.rawValue
                hoursBadges.append(Badge(name: badgeName, image: UIImage(named: "\(badgeName)")!))
            }
            
            for badge in student.badges.filter({ $0.value >= 5 }) {
                skillsBadges.append(Badge(name: badge.key, image: UIImage(named: "\(badge.key)")!))
            }
            
        }
        
        lastBadgeImage.image = hoursBadges.last?.image
        lastBadgeName.text = hoursBadges.last?.name
        
    }
    
    //MARK: - IBAcitions
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    

    
}

extension BadgesVC: UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear 
        return footerView
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BadgesContentCell") as! BadgesContentCell
        
        if indexPath.section == 0 {
            cell.titleLabel.text = "للساعات التطوعية"
            cell.badges = hoursBadges
        } else {
            cell.titleLabel.text = "للمهارات المكتسبة"
            cell.badges = skillsBadges
        }
       
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

}
