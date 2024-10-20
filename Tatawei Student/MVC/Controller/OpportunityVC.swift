//
//  OpportunityVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 16/04/1446 AH.
//

import UIKit

class OpportunityVC: UIViewController, Storyboarded {
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    
    //MARK: - IBOutleats
    
    @IBOutlet weak var opportunityImage: DesignableImage!
    @IBOutlet weak var opportunityName: UILabel!
    
    
    @IBOutlet weak var organisationImage: UIImageView!
    @IBOutlet weak var organisationName: UILabel!
    
    @IBOutlet weak var opportunityDescription: UILabel!
    @IBOutlet weak var opportunityTime: UILabel!
    @IBOutlet weak var opportunityLocation: UILabel!
    @IBOutlet weak var opportunityHour: UILabel!
    @IBOutlet weak var opportunityStudentsNumber: UILabel!
    @IBOutlet weak var opportunityStudentsRegisted: UILabel!
    
    @IBOutlet weak var applyBTN: DesignableButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: - IBAcitions
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didPressedApply(_ sender: UIButton) {
        coordinator?.viewAcceptanceApplyVC()
    }
    
    @IBAction func openTheOrganisationInformation(_ sender: UIButton) {
        coordinator?.viewOrganizationVC()
    }
    
    //MARK: - Functions

}
