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
        MenuItem(image: UIImage(systemName: "globe")!, label: .changeLanguage),
        MenuItem(image: UIImage(systemName: "info.circle.fill")!, label: .about),
        MenuItem(image: UIImage(systemName: "lock.open.rotation")!, label: .resetPassword),
        MenuItem(image: UIImage(systemName: "trash.fill")!, label: .deleteAccount),
        MenuItem(image: UIImage(systemName: "minus.circle.fill")!, label: .logout)
                 ]
    
    //MARK: - IBOutleats
    
    @IBOutlet weak var studentName: UILabel!
    
    @IBOutlet weak var studentEmail: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getStudentInformation()
        
    }
    
    
    //MARK: - IBAcitions
    
    
    //MARK: - Functions
    
    func getStudentInformation() {
        if let student = Student.currentStudent {
            
            studentName.text = student.name
            studentEmail.text = student.email
            
            print(student.name)
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
        case .changeLanguage:
            print("")
            
            // About Us
        case .about:
            print("")
            
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

