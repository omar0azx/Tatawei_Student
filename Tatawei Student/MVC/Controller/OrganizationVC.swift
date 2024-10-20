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
    
    
    //MARK: - IBOutleats
    
    @IBOutlet weak var organisationImage: DesignableImage!
    @IBOutlet weak var organisationName: UILabel!
    @IBOutlet weak var organisationEmail: UILabel!
    @IBOutlet weak var organisationRate: UILabel!
    @IBOutlet weak var numberOfResidents: UILabel!
    @IBOutlet weak var organisationDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - IBAcitions
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    //MARK: - Functions
    
}
