//
//  OrganizationVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 17/04/1446 AH.
//

import UIKit

class OrganizationVC: UIViewController, Storyboarded {
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    var organizationID: String?
    
    
    //MARK: - IBOutleats
    
    @IBOutlet weak var organisationImage: UIImageView!
    @IBOutlet weak var organisationName: UILabel!
    @IBOutlet weak var organisationEmail: UILabel!
    @IBOutlet weak var organisationRate: UILabel!
    @IBOutlet weak var numberOfResidents: UILabel!
    @IBOutlet weak var organisationDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOpportunituInformaion()
    }
    
    
    
    //MARK: - IBAcitions
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    //MARK: - Functions
    
    func getOpportunituInformaion() {
        if let organizationID = organizationID {
            OpportunityDataServices.shared.getOrganisationData(organisationID: organizationID, completion: { organisation in
                if let organisation = organisation {
                    var organizationImag: UIImage?
                    StorageService.shared.downloadImage(from: organisation.organizationImageLink) { imag, error in
                        guard let image = imag else {return}
                        organizationImag = image
                    }
                    self.organisationImage.image = organizationImag
                    self.organisationName.text = organisation.name
                    self.organisationEmail.text = organisation.email
                    self.organisationRate.text = String(format: "%.1f", organisation.rate)
                    self.numberOfResidents.text = "(\(organisation.numberOfReviewers)) مراجع"
                    self.organisationDescription.text = organisation.description
                    
                } else {
                    print("cannot get organization information")
                }
            })
        }
    }
    
}
