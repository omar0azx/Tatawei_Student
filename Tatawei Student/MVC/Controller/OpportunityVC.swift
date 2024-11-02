//
//  OpportunityVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 16/04/1446 AH.
//

import UIKit

class OpportunityVC: UIViewController, Storyboarded {
    
    enum Mode {
        case applyToOpportunity
        case cancelApplying
        case shareReport
        case studentNotRegistered
    }
    
    
    //MARK: - Varibales
    
    var mode: Mode = .applyToOpportunity
    
    var coordinator: MainCoordinator?
    
    var opportunity: Opportunity?
    
    let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Cairo-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18)
    ]
    
    
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
        definePageType()
    }
    
    
    //MARK: - IBAcitions
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didPressedApply(_ sender: UIButton) {

        applyBTN.titleLabel?.font = UIFont(name: "Cairo", size: 30)
        let loadView = MessageView(message: "يرجى الإنتظار", animationName: "loading", animationTime: 1)
        loadView.show(in: self.view)
        
        if let opportunity = opportunity {
            
            switch mode {
            case .applyToOpportunity:
                OpportunityDataServices.shared.applyToOpportunity(studentID: Student.currentID, opportunity: opportunity) { status, error in
                    if status {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.coordinator?.viewAcceptanceApplyVC()
                        }
                    } else {
                        let errorView = MessageView(message: "أنت مسجل بالفعل !", animationName: "warning", animationTime: 1)
                        errorView.show(in: self.view)
                    }
                }
            case .cancelApplying:
                OpportunityDataServices.shared.cancelOpportunityRegistration(studentID: Student.currentID, opportunity: opportunity) { status, error in
                    if status {
                        self.mode = .applyToOpportunity
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            let attributedTitle = NSAttributedString(string: "تقديم الآن", attributes: self.attributes)
                            self.applyBTN.setAttributedTitle(attributedTitle, for: .normal)
                            self.applyBTN.backgroundColor = .standr
                        }
                        self.updateStudentData()
                        print("Successfully canceled the registration.")
                    } else {
                        print("Error canceling registration:", error?.localizedDescription ?? "Unknown error")
                    }
                }
            case .shareReport:
                print("")
            case .studentNotRegistered:
                displayAlertMessage()
            }
        } else {
            let errorView = MessageView(message: "تاكد من معلوماتك", animationName: "warning", animationTime: 1)
            errorView.show(in: self.view)
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
            opportunityImage.image = Icon(index: opportunity.iconNumber, categories: opportunity.category).opportunityIcon.0
            opportunityView.backgroundColor = Icon(index: opportunity.iconNumber, categories: opportunity.category).opportunityIcon.1
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
    
    func updateStudentData() {
        if let schoolID = Student.currentStudent?.school {
            StudentDataServices.shared.getStudentData(schoolID: schoolID, studentID: Student.currentID) { status, error in
                if status! {
                    print("Success to update locally storage")
                } else {
                    print("Have problem when update locally storage")
                }
            }
        }
    }
    
    func definePageType() {
        if let student = Student.currentStudent {
            if student.isStudentRegisteredScool {
                if student.opportunities.contains(opportunity!.id) {
                    mode = .cancelApplying
                   let attributedTitle = NSAttributedString(string: "إلغاء التسجيل", attributes: self.attributes)
                    self.applyBTN.setAttributedTitle(attributedTitle, for: .normal)
                    applyBTN.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3529411765, blue: 0.3529411765, alpha: 1)
                } else {
                    mode = .applyToOpportunity
                    applyBTN.backgroundColor = .standr
                }
            } else {
                mode = .studentNotRegistered
                applyBTN.backgroundColor = .systemGray3
            }
            
        }
    }
    
}
