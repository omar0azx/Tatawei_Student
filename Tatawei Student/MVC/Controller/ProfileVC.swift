//
//  ProfileVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 18/03/1446 AH.
//

import UIKit

class ProfileVC: UIViewController, Storyboarded {
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    var settings: [MenuItem] = [
        MenuItem(image: UIImage(systemName: "book.pages.fill")!, label: .termsAndConditions),
        MenuItem(image: UIImage(systemName: "questionmark.bubble.fill")!, label: .FrequentlyAskedQuestions),
        MenuItem(image: UIImage(systemName: "info.circle.fill")!, label: .about),
        MenuItem(image: UIImage(systemName: "lock.open.rotation")!, label: .resetPassword),
        MenuItem(image: UIImage(systemName: "trash.fill")!, label: .deleteAccount),
        MenuItem(image: UIImage(systemName: "minus.circle.fill")!, label: .logout)
                 ]
    
    //MARK: - IBOutleats
    
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentEmail: UILabel!
    @IBOutlet weak var studentOpportunities: UILabel!
    @IBOutlet weak var studentHoursCompleted: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getStudentInformation()
        
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        getStudentInformation()
    }

    
    //MARK: - IBAcitions
    
    @IBAction func editProfile(_ sender: UIButton) {
        self.coordinator?.viewEditProfileVC()
    }
    
    //MARK: - Functions
    
    func getStudentInformation() {
        if let student = Student.currentStudent {
            studentImage.image = student.gender == .male ? #imageLiteral(resourceName: "man.svg") : #imageLiteral(resourceName: "women.svg")
            studentName.text = student.name
            studentEmail.text = student.email
            studentOpportunities.text = student.opportunities.count == 0 ? "0": String(student.opportunities.count)
            studentHoursCompleted.text = String(Int(student.hoursCompleted))
        }
        
    }
    
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsCell
        cell.configure(menuItem: settings[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch settings[indexPath.row].label {
            // Change Language
        case .termsAndConditions:
            
            coordinator?.viewWebVC(url: "https://drive.google.com/file/d/1Bu1MXmMzC-D92-4p6hgOVoNiv_fuMGmD/view?usp=share_link")
            
        case .FrequentlyAskedQuestions:
        self.coordinator?.viewQuestionsVC()
            
            // About Us
        case .about:
        self.coordinator?.viewAboutVC()
            // Reset Password
        case .resetPassword:
            showCustomAlert(message: "هل أنت متأكد من انك تريد إعادة تعيين كلمة المرور؟", onConfirm: {
                self.coordinator?.viewforgetPasswordVC(animation: true)
                    }, onCancel: {
                        print("Action cancelled")
                    })
            
            // Delete Account
        case .deleteAccount:
            showCustomAlert(message: "هل أنت متأكد من انك تريد من حذف حسابك ؟", onConfirm: {
                AuthService.shared.deleteAccount { error in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.coordinator?.viewLoginVC()
                        }
                    }
                }
                    }, onCancel: {
                        print("Action cancelled")
                    })
            
            // Logout
        case .logout:
            showCustomAlert(message: "هل أنت متأكد من انك تريد تسجيل الخروج من حسابك ؟", onConfirm: {
                AuthService.shared.logoutCurrentUser { error in
                    if error == nil {
                        DispatchQueue.main.async {
                            self.coordinator?.viewLoginVC()
                        }
                    }
                }
                    }, onCancel: {
                        print("Action cancelled")
                    })
        }
        
    }
    
}
