//
//  BadgesVC.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 05/11/2024.
//

import UIKit

class BadgesVC: UIViewController {

    //MARK: - Varibales
    
    var coordinator: MainCoordinator?

    //MARK: - IBOutleats

    @IBOutlet weak var lastBadgeImage: UIImageView!
    @IBOutlet weak var lastBadgeName: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        lastBadgeImage.image = allBadgesForStudent.last?.image
        lastBadgeName.text = allBadgesForStudent.last?.name

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
            cell.collectionView.tag = 0
        } else {
            cell.titleLabel.text = "للمهارات المكتسبة"
            cell.collectionView.tag = 1
        }
       
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

}
