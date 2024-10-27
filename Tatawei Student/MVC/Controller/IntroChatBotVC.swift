//
//  IntroChatBotVC.swift
//  Tatawei Student
//
//  Created by testuser on 24/04/1446 AH.
//

import UIKit

class IntroChatBotVC: UIViewController, Storyboarded {
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    
    //MARK: - IBOutleats
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    //MARK: - IBAcitions
    
    
    @IBAction func exit(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Functions
  
}
