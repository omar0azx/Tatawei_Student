//
//  ForgetPasswordVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 29/03/1446 AH.
//

import UIKit

class ForgetPasswordVC: UIViewController, Storyboarded {
    
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: true)
        }
        
    }

}
