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
    
    var opportunity: Opportunity?
    
    
    //MARK: - IBOutleats
    
    @IBOutlet var opportunityView: UIView!
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
        getOpportunituInformaion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let student = Student.currentStudent {
            if student.isStudentRegisteredScool {
                applyBTN.backgroundColor = .standr
            } else {
                applyBTN.backgroundColor = .systemGray3
            }
        }
    }
    

    //MARK: - IBAcitions
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didPressedApply(_ sender: UIButton) {
        if applyBTN.backgroundColor == .standr {
            coordinator?.viewAcceptanceApplyVC()
        } else {
            displayAlertMessage()
        }
    }
    
    @IBAction func openTheOrganisationInformation(_ sender: UIButton) {
        if let opportunity = opportunity {
            coordinator?.viewOrganizationVC(organizationID: opportunity.organizationID)
        }
    }
    
    //MARK: - Functions
    
    func getOpportunituInformaion() {
        if let opportunity = opportunity {
            var organizationImag: UIImage?
            StorageService.shared.downloadImage(from: opportunity.organizationImageLink) { imag, error in
                guard let image = imag else {return}
                organizationImag = image
            }
            opportunityImage.image = Icon(index: opportunity.iconNumber, categories: opportunity.category).icons.0
            opportunityView.backgroundColor = Icon(index: opportunity.iconNumber, categories: opportunity.category).icons.1
            opportunityName.text = opportunity.name
            opportunityDescription.text = opportunity.description
            opportunityTime.text = opportunity.time
            opportunityHour.text = "ساعات \(opportunity.hour)"
            opportunityLocation.text = opportunity.location
            organisationName.text = opportunity.organizationName
            organisationImage.image = organizationImag
        }
    }
    
    func displayAlertMessage() {
        let alertController = UIAlertController(title: "إنتظار قبول المدرسة", message: "لن تستطيع التقديم على الفرص التطوعية حتى يتم قبولك من قبل مشرف الطوع في مدرستك", preferredStyle: .actionSheet)
        let OKAction = UIAlertAction(title: "حسنا", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
