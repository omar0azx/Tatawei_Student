//
//  AcceptanceApplyVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 17/04/1446 AH.
//

import UIKit

class AcceptanceApplyVC: UIViewController, Storyboarded {
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    
    //MARK: - IBOutleats
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: - IBAcitions
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didPressedViewStanderd(_ sender: Any) {
        coordinator?.viewStandardAcceptanceVC()
    }
    
    //MARK: - Functions

}
