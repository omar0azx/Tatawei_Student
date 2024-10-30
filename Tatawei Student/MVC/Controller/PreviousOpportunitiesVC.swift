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
    var arrOppt = [Opportunity]()

    
    //MARK: - IBOutleats
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStudentOpportunities()
    }
    
    
    //MARK: - IBAcitions
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    //MARK: - Functions
    
    func loadStudentOpportunities() {
        // Check if the current student has any opportunities
        if let studentOpportunities = Student.currentStudent?.opportunities, !studentOpportunities.isEmpty {
            
            // Proceed only if studentOpportunities is non-empty
            OpportunityDataServices.shared.getStudentOpportunities(opportunityIDs: studentOpportunities) { opportunities, error in
                
                if let error = error {
                    print("Error fetching student opportunities: \(error.localizedDescription)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.arrOppt = opportunities
                    self.tableView.reloadData()
                }
            }
        } else {
            // Handle the case where the opportunities array is empty
            print("No opportunities available for the current student.")
            
        }
    }
    
    
}
    
extension PreviousOpportunitiesVC: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOppt.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviousOpportunitiesCell") as! PreviousOpportunitiesCell
        let cellColorAndIcon = Icon(index: arrOppt[indexPath.row].iconNumber, categories: arrOppt[indexPath.row].category).icons
        let isFirstCell = indexPath.row == 0
        let isLastCell = indexPath.row == arrOppt.count - 1

        cell.configOpportunity(opportunityName: arrOppt[indexPath.row].name, opportunityTime: arrOppt[indexPath.row].time, opportunityDate: arrOppt[indexPath.row].date, organizationImage: cellColorAndIcon.0, isFirstCell: isFirstCell, isLastCell: isLastCell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }


    }
    
    
    


