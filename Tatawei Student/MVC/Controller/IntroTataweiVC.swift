//
//  IntroTataweiVC.swift
//  Tatawei Student
//
//  Created by testuser on 07/05/1446 AH.
//

import UIKit

class IntroTataweiVC: UIViewController, Storyboarded {
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    
    //MARK: - IBOutleats
    
    @IBOutlet weak var tatawei: UIStackView!
    
    @IBOutlet weak var titel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       animateViews()
        
    }
    
    //MARK: - IBAcitions
    
    
    
    
    //MARK: - Functions
    
    func animateViews() {
        // Fade back in
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 1) {
                self.tatawei.isHidden = false
                self.tatawei.alpha = 1
                self.loadViewIfNeeded()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                UIView.animate(withDuration: 1) {
                    self.titel.isHidden = false
                    self.titel.alpha = 1
                    self.loadViewIfNeeded()
                }
            }
        }
    }
    
}



