//
//  AboutVC.swift
//  Tatawei Student
//
//  Created by testuser on 22/04/1446 AH.
//

import UIKit

class AboutVC: UIViewController, Storyboarded {
    
    
    var coordinator: MainCoordinator?
    
    
    //MARK: - Varibales
    
    var isFirstState = true
    var isFinalState = false
    
    
    //MARK: - IBOutleats
    
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var aboutImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var centerXConstaint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        updateViewSizes(forPage: 0)
    }
    
    //MARK: - IBAcitions
    
    @IBAction func next(_ sender: UIButton) {
        
        if isFinalState {
            self.dismiss(animated: true)
        }
        
        if isFirstState {
            
            titleLabel.text = "فوائد العمل التطوعي"
            descriptionLabel.text = "النمو الشخصي، تطوير المهارات، والشعور بالإنجاز. يربطك بمجتمعك، يوسع شبكة علاقاتك، ويوفر فرصًا لإحداث تأثير ذي معنى."
            aboutImage.image = UIImage(named:"benefits-tatawei")
            
            updateViewSizes(forPage: 1)
            
        } else {
            
            titleLabel.text = "لننطلق في هذه التجربة"
            descriptionLabel.text = "التطوع يثري الحياة بطرق لا تعد ولا تحصى، حيث يربط الأفراد بمجتمعات متنوعة، ويصقل المهارات، ويغرس شعوراً عميقاً بالإنجاز. المساهمة في قضايا ذات معنى مجزية للغاية وتشكل الآفاق بعمق."
            aboutImage.image = UIImage(named: "go-volunteering-trip")
            
            sender.setTitle("ابدا", for: .highlighted)
            
            UIView.animate(withDuration: 0.2) {
                self.width.constant = self.view.frame.width * 0.8
                self.centerXConstaint.constant = 0
                self.view.layoutIfNeeded()
            }
            
            arrowImage.isHidden = true
            
            isFinalState = true
            updateViewSizes(forPage: 2)
        }
        
        isFirstState.toggle()
        
        
    }
    
    
    //MARK: - Functions
    
    func updateViewSizes(forPage page: Int) {
        for (index, view) in views.enumerated() {
            if index == page {
                view.backgroundColor = .standr
                view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            } else {
                view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
                view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
    
    
    
    
    
    
}
