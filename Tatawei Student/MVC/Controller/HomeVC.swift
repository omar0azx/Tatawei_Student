//
//  HomeVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 18/03/1446 AH.
//

import UIKit

struct opportunities {
    var name: String
    var date: String
    var organizationIcon: UIImage
    var opportunityHours: Int
    var accecptanceStatus: Bool
    var opportunityIcon: UIImage
    var BGColor: UIColor
    var time: String
    
}

class HomeVC: UIViewController, Storyboarded {
    
    
    //MARK: - Varibales
    
    // The shape layer used to display the progress.
    let shapeLayer = CAShapeLayer()
    // The student object that contains the student's data.
    var student: Student?
    
    var coordinator: MainCoordinator?
    
    var arrOppt = [opportunities]()
    
    //MARK: - IBOutleats
    
    @IBOutlet weak var textHoursLBL: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var welcomeLBL: UILabel!
    @IBOutlet weak var hoursAchievedLBL: UILabel!
    @IBOutlet weak var descriptionHoursLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        setUpProgressAnimat()
        handleAnimation()
        
        
    }
    
    
    //MARK: - IBAcitions
    
    
    //MARK: - Functions
    
    private func setupUI() {
        welcomeLBL.text = "🖐🏼 أهلاً \(student?.name ?? "وسام"), "
        descriptionHoursLBL.text = "لقد اتممت \(student?.hoursCompleted ?? 0)  من 40 ساعة"
        
        progressView.addSubview(hoursAchievedLBL)
        progressView.addSubview(textHoursLBL)
    }
    
    private func setUpProgressAnimat() {
        // Create a circular path for the progress view.
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2), radius: 45, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi * 2, clockwise: true)
        
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
        shapeLayer.strokeColor = UIColor(red: 1, green: 169, blue: 158, alpha: 0.5).cgColor
        
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
        //            basicAnimation.toValue =  (self.student?.hoursCompleted ?? 0) * 0.02
        basicAnimation.toValue =  20 * 0.02
        basicAnimation.duration = 4.5
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urBasic")
    }
}


extension HomeVC: UICollisionBehaviorDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOppt.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OpportunitiesCell", for: indexPath) as! OpportunitiesCell
        let oppt = arrOppt[indexPath.row]
        cell.configOpportunity(backgroundColor: oppt.BGColor, opportunityImage: oppt.opportunityIcon, opportunityName: oppt.name, opportunityTime: oppt.time, opportunityHour: oppt.opportunityHours, opportunityDate: oppt.date, organizationImage: oppt.organizationIcon, status: oppt.accecptanceStatus)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.2
    }

}
