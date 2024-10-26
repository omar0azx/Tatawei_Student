//
//  PreviousOpportunitiesVC.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 24/10/2024.
//

import UIKit

class PreviousOpportunitiesVC: UIViewController, Storyboarded {
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    var arrOppt = [opportunities]()

    
    //MARK: - IBOutleats
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        arrOppt.append(opportunities(name: "تنظيم", date: "اليوم", organizationIcon: UIImage.iftar , opportunityHours: 5, accecptanceStatus: true, opportunityIcon: UIImage.robot, BGColor: .standr3, time: "5:00 PM"))
        arrOppt.append(opportunities(name: "تنظيم", date: "اليوم", organizationIcon: UIImage.iftar , opportunityHours: 5, accecptanceStatus: true, opportunityIcon: UIImage.robot, BGColor: .standr3, time: "5:00 PM"))
        arrOppt.append(opportunities(name: "تنظيم", date: "اليوم", organizationIcon: UIImage.iftar , opportunityHours: 5, accecptanceStatus: true, opportunityIcon: UIImage.robot, BGColor: .standr3, time: "5:00 PM"))
        arrOppt.append(opportunities(name: "تنظيم", date: "اليوم", organizationIcon: UIImage.iftar , opportunityHours: 5, accecptanceStatus: true, opportunityIcon: UIImage.robot, BGColor: .standr3, time: "5:00 PM"))

    }
    
    
    //MARK: - IBAcitions
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    //MARK: - Functions
    
    
    
}
    
extension PreviousOpportunitiesVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOppt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviousOpportunitiesCell") as! PreviousOpportunitiesCell
        
        let isFirstCell = indexPath.row == 0
        let isLastCell = indexPath.row == arrOppt.count - 1

        let oppt = arrOppt[indexPath.row]
        cell.configOpportunity(opportunityName: oppt.name, opportunityTime: oppt.time, opportunityHours: oppt.opportunityHours, opportunityDate: oppt.date, organizationImage: oppt.organizationIcon, isFirstCell: isFirstCell, isLastCell: isLastCell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }


    }
    
    
    


