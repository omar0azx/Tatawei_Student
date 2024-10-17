//
//  EducationVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 18/03/1446 AH.
//

import UIKit

class EducationVC: UIViewController, Storyboarded {
    
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    
    //MARK: - IBOutleats
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    //MARK: - IBAcitions
    
    @IBAction func listBtn(_ sender: UIButton) {
        coordinator?.viewWebVC(url: "https://www.hrsd.gov.sa/knowledge-centre/decisions-and-regulations/regulation-and-procedures/1170256")
    }
    
    @IBAction func conceptBtn(_ sender: UIButton) {
        coordinator?.viewWebVC(url: "https://mawdoo3.com/مفهوم_العمل_التطوعي")
    }
    
    @IBAction func pathsBtn(_ sender: UIButton) {
        coordinator?.viewWebVC(url: "https://edutec4all.medu.sa/wp-content/uploads/2024/05/دليل-العمل-التطوعي-في-مسارات-الثانوية.pdf")
    }
    
    @IBAction func youtubeBtn(_ sender: UIButton) {
        coordinator?.viewWebVC(url: "https://youtu.be/wgr_2q2Ydvc?si=z466E07NUHwJNYxs")
    }
    
    //MARK: - Functions
    
    
}
