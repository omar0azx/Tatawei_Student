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
        updateStudentData()
        
    }
    

    //MARK: - IBAcitions
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didPressedViewStanderd(_ sender: Any) {
        coordinator?.viewStandardAcceptanceVC()
    }
    
    //MARK: - Functions
    
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
    
}
