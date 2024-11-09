//
//  StudentProgressVC.swift
//  Tatawei Student
//
//  Created by Wesam Kadah on 06/11/2024.
//

import UIKit

class StudentProgressVC: UIViewController, Storyboarded {

    //MARK: - Varibales
    
    // The shape layer used to display the progress.
    let shapeLayer = CAShapeLayer()

    var coordinator: MainCoordinator?
    
    //MARK: - IBOutleats
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var percentageValue: UILabel!
    @IBOutlet weak var lastBadegName: UILabel!
    @IBOutlet weak var lastBadegImage: UIImageView!
    @IBOutlet weak var totalOpportunities: UILabel!
    @IBOutlet weak var remainHours: UILabel!
    @IBOutlet weak var compleatedHours: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let student = Student.currentStudent {
            percentageValue.text = "\(Int((student.hoursCompleted) / 40 * 100))%"
//            lastBadegImage.image = allBadgesForStudent.last?.image
            totalOpportunities.text = "\(student.opportunities.count) / ف"
            remainHours.text = "5 / س"
            compleatedHours.text = "\(Int(student.hoursCompleted)) / س"
        }

        updateBadgeLabel()
        setUpProgressAnimat()
        handleAnimation()

    }
    
    //MARK: - IBAcitions
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func showAllBadges(_ sender: UIButton) {
        coordinator?.viewBadgesVC()
    }
    
    //MARK: - Functions

    func updateBadgeLabel() {
        
        if let studentHours = Student.currentStudent?.hoursCompleted {
            if studentHours >= 5 {
                lastBadegName.text = "يمكنك رؤية جميع الأوسمة التي تم الحصول عليها"
                lastBadegImage.image = #imageLiteral(resourceName: "مختم التطوع")
            } else {
                lastBadegName.text = "لم تكمل أي ساعة تطوعية"
                lastBadegImage.image = #imageLiteral(resourceName: "emty.png")
            }
        } else {
            
        }

    }

    private func setUpProgressAnimat() {
        // Create a circular path for the progress view.
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2), radius: 90, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi * 2, clockwise: true)
        
        // Create a track layer for the progress view.
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        progressView.layer.addSublayer(trackLayer)
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 9.5
        
        // Set up the shape layer.
        shapeLayer.path = circularPath.cgPath
        progressView.layer.addSublayer(shapeLayer)
        shapeLayer.strokeColor = UIColor(.standr).cgColor
        
        shapeLayer.strokeEnd = 0
        shapeLayer.lineWidth = 9.5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        
        // Create a mask layer for the progress view.
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(ovalIn: progressView.bounds).cgPath
        progressView.layer.mask = maskLayer
    }
    
    private func handleAnimation() {
        // Create a basic animation for the stroke end.
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = 0
        basicAnimation.toValue =  (Student.currentStudent?.hoursCompleted ?? 5) * 0.02
        basicAnimation.duration = 4.5
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urBasic")
    }


    


}
