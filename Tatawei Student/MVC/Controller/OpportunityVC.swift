//
//  OpportunityVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 16/04/1446 AH.
//

import UIKit
import QuickLook

class OpportunityVC: UIViewController, Storyboarded {
    
    enum Mode {
        case applyToOpportunity
        case cancelApplying
        case shareReport
        case studentNotRegistered
    }
    
    
    //MARK: - Varibales
    
    var mode: Mode = .applyToOpportunity
    
    var coordinator: MainCoordinator?
    
    var opportunity: Opportunity?
    
    var pdfURL: URL? // URL of the created PDF file
    var text: String?
    var fileName: String?
    
    let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Cairo-Regular", size: 18) ?? UIFont.systemFont(ofSize: 18)
    ]
    
    
    //MARK: - IBOutleats
    
    @IBOutlet var opportunityView: UIView!
    @IBOutlet weak var opportunityImage: DesignableImage!
    @IBOutlet weak var opportunityName: UILabel!
    
    
    @IBOutlet weak var organisationImage: UIImageView!
    @IBOutlet weak var organisationName: UILabel!
    
    @IBOutlet weak var opportunityDescription: UILabel!
    @IBOutlet weak var opportunityTime: UILabel!
    @IBOutlet weak var opportunityLocation: UILabel!
    @IBOutlet weak var opportunityHour: UILabel!
    @IBOutlet weak var opportunityStudentsNumber: UILabel!
    
    @IBOutlet weak var applyBTN: DesignableButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        definePageType()
        getOpportunituInformaion()
        if mode == .shareReport {
            createReport()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        definePageType()
    }
    
    
    //MARK: - IBAcitions
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didPressedApply(_ sender: UIButton) {
        
        if let opportunity = opportunity, let isStudentRegisteredScool = Student.currentStudent?.isStudentAccepted {
            if isStudentRegisteredScool == 1 {
                let loadView = MessageView(message: "يرجى الإنتظار", animationName: "loading", animationTime: 1)
                loadView.show(in: self.view)
            }
            switch mode {
            case .applyToOpportunity:
                OpportunityDataServices.shared.applyToOpportunity(studentID: Student.currentID, opportunity: opportunity) { status, error in
                    if status {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.coordinator?.viewAcceptanceApplyVC()
                        }
                    } else {
                        let errorView = MessageView(message: "أنت مسجل بالفعل !", animationName: "warning", animationTime: 1)
                        errorView.show(in: self.view)
                    }
                }
            case .cancelApplying:
                OpportunityDataServices.shared.cancelOpportunityRegistration(studentID: Student.currentID, opportunity: opportunity) { status, error in
                    if status {
                        self.mode = .applyToOpportunity
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            let attributedTitle = NSAttributedString(string: "تقديم الآن", attributes: self.attributes)
                            self.applyBTN.setAttributedTitle(attributedTitle, for: .normal)
                            self.applyBTN.backgroundColor = .standr
                        }
                        self.updateStudentData()
                        print("Successfully canceled the registration.")
                    } else {
                        print("Error canceling registration:", error?.localizedDescription ?? "Unknown error")
                    }
                }
            case .shareReport:
                guard let pdfURL = pdfURL, FileManager.default.fileExists(atPath: pdfURL.path) else {
                    print("PDF file not found")
                    return
                }
                
                let previewController = QLPreviewController()
                previewController.dataSource = self
                present(previewController, animated: true, completion: nil)
            case .studentNotRegistered:
                displayAlertMessage()
            }
        } else {
            let errorView = MessageView(message: "تاكد من معلوماتك", animationName: "warning", animationTime: 1)
            errorView.show(in: self.view)
        }
    }
    
    @IBAction func openTheOrganisationInformation(_ sender: UIButton) {
        if let opportunity = opportunity {
            coordinator?.viewOrganizationVC(organizationID: opportunity.organizationID)
        }
    }
    
    
    @IBAction func openLocationInGoogleMaps(_ sender: UIButton) {
        if let opportunity = opportunity {
            if let url = URL(string: "comgooglemaps://?q=\(opportunity.latitude),\(opportunity.longitude)&center=\(opportunity.latitude),\(opportunity.longitude)&zoom=14") {
                // Check if Google Maps is installed
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback to open in browser if Google Maps app is not installed
                    let browserUrl = URL(string: "https://www.google.com/maps/search/?api=1&query=\(opportunity.latitude),\(opportunity.longitude)")!
                    UIApplication.shared.open(browserUrl, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    //MARK: - Functions
    
    func getOpportunituInformaion() {
        if let opportunity = opportunity {
            var organizationImag: UIImage?
            StorageService.shared.downloadImage(from: opportunity.organizationImageLink) { imag, error in
                guard let image = imag else {return}
                organizationImag = image
            }
            opportunityImage.image = Icon(index: opportunity.iconNumber, categories: opportunity.category).opportunityIcon.0
            opportunityView.backgroundColor = Icon(index: opportunity.iconNumber, categories: opportunity.category).opportunityIcon.1
            opportunityName.text = opportunity.name
            opportunityDescription.text = opportunity.description
            opportunityTime.text = opportunity.time
            opportunityHour.text = "ساعات \(opportunity.hour)"
            opportunityLocation.text = opportunity.location
            organisationName.text = opportunity.organizationName
            opportunityStudentsNumber.text = "عدد الطلاب المطلوبين \(opportunity.studentsNumber)"
            organisationImage.image = organizationImag
        }
    }
    
    func displayAlertMessage() {
        let alertController = UIAlertController(title: "إنتظار قبول المدرسة", message: "لن تستطيع التقديم على الفرص التطوعية حتى يتم قبولك من قبل مشرف التطوع في مدرستك", preferredStyle: .actionSheet)
        let OKAction = UIAlertAction(title: "حسنا", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
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
    
    func createReport() {
        if let student = Student.currentStudent, let opportunity = opportunity {
                    fileName = opportunity.name
                    text = """
        تحية طيبة،

        يتقدم فريق التطوع بالشكر والتقدير للطالب \(student.name) على عطائه وإتمامه الفرصة التطوعية في \(opportunity.name).

        تمت الفرصة التطوعية في حي \(opportunity.location) بمدينة \(opportunity.city)، بتاريخ \(opportunity.date)، حيث كانت عن \(opportunity.description).

        تمت الفعالية بمعدل \(opportunity.hour) ساعات تطوعية، وقد ساهم بشكل فعال في الفرصة التطوعية.

        نتمنى للطالب \(student.name) دوام التوفيق والنجاح في مسيرته التطوعية المستقبلية.

        الختم \(opportunity.organizationName):
        """
                }
    }
    
    func definePageType() {
        if mode == .shareReport {
            let attributedTitle = NSAttributedString(string: "فتح التقرير", attributes: self.attributes)
             self.applyBTN.setAttributedTitle(attributedTitle, for: .normal)
            applyBTN.backgroundColor = .standr
            if let text = self.text, let fileName = self.fileName {
                createPDF(from: text, fileName: fileName)
            }
        } else {
            if let student = Student.currentStudent {
                if student.isStudentAccepted == 1 {
                    if student.opportunities.contains(opportunity!.id) {
                        mode = .cancelApplying
                        let attributedTitle = NSAttributedString(string: "إلغاء التسجيل", attributes: self.attributes)
                        self.applyBTN.setAttributedTitle(attributedTitle, for: .normal)
                        applyBTN.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3529411765, blue: 0.3529411765, alpha: 1)
                    } else {
                        mode = .applyToOpportunity
                        applyBTN.backgroundColor = .standr
                    }
                } else {
                    mode = .studentNotRegistered
                    applyBTN.backgroundColor = .systemGray3
                }
                
            }
        }
    }
    
}

extension OpportunityVC: QLPreviewControllerDataSource {
    
    func createPDF(from text: String, fileName: String) {
        // Define PDF page size
        let pageWidth: CGFloat = 8.5 * 72.0 // 8.5 inches in points (72 points per inch)
        let pageHeight: CGFloat = 11 * 72.0 // 11 inches in points
        let pageSize = CGSize(width: pageWidth, height: pageHeight)
        
        // Setup the renderer
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))
        
        // Save PDF to document directory
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.pdfURL = documentDirectory.appendingPathComponent("\(fileName).pdf")
        
        // Generate PDF file
        do {
            try pdfRenderer.writePDF(to: self.pdfURL!) { (context) in
                context.beginPage()
                
                if let backgroundImage = UIImage(named: "tatawei") {
                    let imageWidth = pageSize.width / 2
                    let imageHeight = pageSize.height / 2
                    
                    let aspectWidth = imageWidth / backgroundImage.size.width
                    let aspectHeight = imageHeight / backgroundImage.size.height
                    let aspectRatio = min(aspectWidth, aspectHeight)
                    
                    let scaledImageWidth = backgroundImage.size.width * aspectRatio
                    let scaledImageHeight = backgroundImage.size.height * aspectRatio
                    
                    let imageX = (pageSize.width - scaledImageWidth) / 2
                    let imageY = (pageSize.height - scaledImageHeight) / 2
                    let imageRect = CGRect(x: imageX, y: imageY, width: scaledImageWidth, height: scaledImageHeight)
                    
                    backgroundImage.draw(in: imageRect, blendMode: .normal, alpha: 0.05)
                }
                
                // Draw top-center image (e.g., a logo or emblem)
                if let topCenterImage = UIImage(named: "tatawei") {
                    let topCenterWidth: CGFloat = 60 // Adjust width as needed
                    let topCenterHeight: CGFloat = 60 // Adjust height as needed
                    let topCenterX = (pageSize.width - topCenterWidth) / 2 // Center horizontally
                    let topCenterY: CGFloat = 50 // Adjust distance from the top
                    let topCenterRect = CGRect(x: topCenterX, y: topCenterY, width: topCenterWidth, height: topCenterHeight)
                    topCenterImage.draw(in: topCenterRect)
                }
                
                // Define text attributes
                let textRect = CGRect(x: 20, y: 140, width: pageSize.width - 50, height: pageSize.height - 160) // Adjusted for space below the top-center image
                let textStyle = NSMutableParagraphStyle()
                textStyle.alignment = .right
                textStyle.lineSpacing = 5
                
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont(name: "Cairo", size: 12) ?? UIFont.systemFont(ofSize: 12),
                    .paragraphStyle: textStyle
                ]
                var organizationImag: UIImage?
                if let opportunity = opportunity {
                    StorageService.shared.downloadImage(from: opportunity.organizationImageLink) { imag, error in
                        guard let image = imag else {return}
                        organizationImag = image
                    }
                }
                if let segImage = organizationImag {
                    let topCenterWidth: CGFloat = 60 // Adjust width as needed
                    let topCenterHeight: CGFloat = 60 // Adjust height as needed
                    let topCenterX =  textRect.width - 40 // Center horizontally
                    let topCenterY: CGFloat = textRect.height - 50 // Adjust distance from the top
                    let topCenterRect = CGRect(x: topCenterX, y: topCenterY, width: topCenterWidth, height: topCenterHeight)
                    segImage.draw(in: topCenterRect)
                }
                
                // Draw border around the text area
                let borderPath = UIBezierPath(rect: CGRect(x: 20, y: 20, width: pageSize.width - 40, height: pageSize.height - 40))
                UIColor.black.setStroke() // Border color
                borderPath.lineWidth = 2.0 // Border width
                borderPath.stroke()
                
                // Draw the text inside the border
                text.draw(in: textRect.insetBy(dx: 10, dy: 10), withAttributes: attributes)
            }
            print("PDF created successfully at: \(self.pdfURL!)")
        } catch {
            print("Could not create PDF file: \(error)")
        }
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return pdfURL != nil ? 1 : 0
    }
   
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return pdfURL! as QLPreviewItem
    }
}
