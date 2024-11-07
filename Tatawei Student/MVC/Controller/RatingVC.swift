//
//  RatingVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 30/04/1446 AH.
//

import UIKit

class RatingVC: UIViewController, Storyboarded {
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    var rate = 0
    
    var opportunity: Opportunity?
    
    //MARK: - IBOutleats
    
    @IBOutlet weak var oportunityName: UILabel!
    
    @IBOutlet weak var organisationImage: UIImageView!
    @IBOutlet weak var organisationName: UILabel!
    
    @IBOutlet var starsRating: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getOpportunituInformaion()

    }
    
    //MARK: - IBAcitions
    
    @IBAction func didPressedStarsBTN(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            changeImageColor(index: 0)
            rate = 1
        case 1:
            changeImageColor(index: 1)
            rate = 2
        case 2:
            changeImageColor(index: 2)
            rate = 3
        case 3:
            changeImageColor(index: 3)
            rate = 4
        case 4:
            changeImageColor(index: 4)
            rate = 5
        default:
            print("")
            rate = 0
        }
        if rate > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.dismiss(animated: true)
            }
        }
        
        UserDefaults.standard.set(true, forKey: "hasRatedOpportunityKey")
        rateTheOrganisation(rate: rate)
        
    }
    
    @IBAction func didPressedView(_ sender: UIButton) {
        let errorView = MessageView(message: "يجب عليك تقييم المنظمة اولا للرجوع الى التطبيق", animationName: "warning", animationTime: 2)
        errorView.show(in: self.view)
    }
    
    //MARK: - Functions
    
    func changeImageColor(index: Int) {
        for num in 0...4 {
            if num > index {
                self.starsRating[num].tintColor = .systemGray4
            } else {
                self.starsRating[num].tintColor = #colorLiteral(red: 1, green: 0.7919999957, blue: 0.1570000052, alpha: 1)
            }
        }
    }
    
    func getOpportunituInformaion() {
        if let opportunity = opportunity {
            OpportunityDataServices.shared.getOrganisationData(organisationID: opportunity.organizationID, completion: { organisation in
                if let organisation = organisation {
                    var organizationImag: UIImage?
                    StorageService.shared.downloadImage(from: organisation.organizationImageLink) { imag, error in
                        guard let image = imag else {return}
                        organizationImag = image
                    }
                    self.oportunityName.text = opportunity.name
                    self.organisationImage.image = organizationImag
                    self.organisationName.text = organisation.name
                    
                } else {
                    print("cannot get organization information")
                }
            })
        }
    }
    
    func rateTheOrganisation(rate: Int) {
        if let opportunity = opportunity {
            OpportunityDataServices.shared.updateOrganizationRating(organisationID: opportunity.organizationID, newRate: rate) { status, error in
                if status {
                    print("Rating success")
                } else {
                    print("Rating have error")
                }
            }
        }
    }
    

}

