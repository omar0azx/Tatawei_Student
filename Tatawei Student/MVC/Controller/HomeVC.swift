//
//  HomeVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 18/03/1446 AH.
//

import UIKit

class HomeVC: UIViewController, Storyboarded {
    
    
    //MARK: - Varibales
    
    // The shape layer used to display the progress.
    let shapeLayer = CAShapeLayer()

    var coordinator: MainCoordinator?
    
    var opportunity = [Opportunity]()
    var finishedOpportunities = [Opportunity]()
            
    //MARK: - IBOutleats
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var textHoursLBL: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var welcomeLBL: UILabel!
    @IBOutlet weak var hoursAchievedLBL: UILabel!
    @IBOutlet weak var descriptionHoursLBL: UILabel!
    
    @IBOutlet weak var emtyMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.semanticContentAttribute = .forceRightToLeft
        setupUI()
        setUpProgressAnimat()
        handleAnimation()
        loadStudentOpportunities()

    }
    
    override func viewIsAppearing(_ animated: Bool) {
        loadStudentOpportunities()
        setUpProgressAnimat()
        setupUI()
    }
    
    
    //MARK: - IBAcitions
    @IBAction func historyBTN(_ sender: Any) {
        coordinator?.viewPreviousOpportunitiesVC(opportunities: finishedOpportunities)
    }
    
    @IBAction func showQRCodeBTN(_ sender: Any) {
        coordinator?.viewQRCodeVC()
    }
    
    
    //MARK: - Functions
    
    private func setupUI() {
        
        if let student = Student.currentStudent {
            
            if let firstName = student.name.split(separator: " ").first {
                welcomeLBL.text = "🖐🏼 أهلاً \(firstName)"
            }
            descriptionHoursLBL.text = "لقد اتممت \(Int(student.hoursCompleted)) من 40 ساعة"
            hoursAchievedLBL.text = "\(Int(student.hoursCompleted))"
            progressView.addSubview(hoursAchievedLBL)
            progressView.addSubview(textHoursLBL)
        }
    }
    
    
    func loadStudentOpportunities() {
        if let studentOpportunities = Student.currentStudent?.opportunities, !studentOpportunities.isEmpty {
            
            // Proceed only if studentOpportunities is non-empty
            OpportunityDataServices.shared.getStudentOpportunities(opportunityIDs: studentOpportunities) { opportunities, error in
                
                if let error = error {
                    print("Error fetching student opportunities: \(error.localizedDescription)")
                    return
                }
                DispatchQueue.main.async {
                    self.opportunity = opportunities.sorted {
                        guard let date1 = $0.formattedDate, let date2 = $1.formattedDate else {
                            return false
                        }
                        return date1 < date2
                    }
                    if self.opportunity[0].date == DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none) {
                        saveOpportunityLocally(self.opportunity[0])
                    } else {
                        resetRatingStatus()
                    }
                    self.finishedOpportunities = self.opportunity.filter{$0.status == .finished}
                    self.opportunity = self.opportunity.filter{$0.status == .open || $0.status == .inProgress}
                    self.collectionView.reloadData()
                }
            }
        } else {
            // Handle the case where the opportunities array is empty
            opportunity = []
            collectionView.reloadData()
            print("No opportunities available for the current student.")
            
        }
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
        shapeLayer.strokeColor = UIColor(#colorLiteral(red: 0.1647058824, green: 0.1647058824, blue: 0.1647058824, alpha: 1)).cgColor
        
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


extension HomeVC: UICollisionBehaviorDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if opportunity.count == 0 {
            emtyMessage.isHidden = false
            emtyMessage.alpha = 1
        } else {
            emtyMessage.isHidden = true
            emtyMessage.alpha = 0
        }
        return opportunity.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellColorAndIcon = Icon(index: opportunity[indexPath.row].iconNumber, categories: opportunity[indexPath.row].category).opportunityIcon
        var organizationImag: UIImage?
        StorageService.shared.downloadImage(from: opportunity[indexPath.row].organizationImageLink) { imag, error in
            guard let image = imag else {return}
            organizationImag = image
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OpportunitiesCell", for: indexPath) as! OpportunitiesCell
        if opportunity[indexPath.row].date == DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none) {
            opportunity[indexPath.row].date  = "اليوم"
        }
        cell.configOpportunity(backgroundColor: cellColorAndIcon.1, opportunityImage: cellColorAndIcon.0, opportunityName: opportunity[indexPath.row].name, opportunityTime: opportunity[indexPath.row].time, opportunityHour: opportunity[indexPath.row].hour, opportunityDate: opportunity[indexPath.row].date, organizationImage: organizationImag ?? #imageLiteral(resourceName: "P2.svg"), status: opportunity[indexPath.row].isAccepted!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.viewOpportunityVC(opportunity: opportunity[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.4, height: collectionView.bounds.height * 1 )
    }
    
}
