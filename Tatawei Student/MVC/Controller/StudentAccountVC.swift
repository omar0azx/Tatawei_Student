//
//  RegisterVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 24/03/1446 AH.
//

import UIKit

class StudentAccountVC: UIViewController, Storyboarded, DataSelectionDelegate {
    
    enum Mode {
            case register
            case editProfile
        }
    
    //MARK: - Varibales
    
    var mode: Mode = .register
    
    var coordinator: MainCoordinator?
    
    var stepNumber = 0
    
    var interestsType: [InterestCategories] = [.Cultural, .Financial, .Social, .Sports, .Technical, .Tourism, .Cultural, .Financial, .Social, .Sports, .Technical, .Tourism, .Cultural, .Financial, .Social, .Sports, .Technical, .Tourism]
    var selectedInterestsType = [InterestCategories]()
    var selectedIndexPaths = [IndexPath]()
    
    
    //MARK: - IBOutleats
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var backBTN: UIButton!
    
    @IBOutlet weak var widthPar: NSLayoutConstraint!
    
    @IBOutlet weak var nextBTN: DesignableButton!
    
    //View One
    
    @IBOutlet weak var informationUserView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var passwordStackView: UIStackView!
    
    //View Two
    
    @IBOutlet weak var informationSchoolView: UIView!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var schoolTF: UITextField!
    @IBOutlet weak var levelTF: UITextField!
    @IBOutlet weak var mapInformation: UILabel!
    
    //View Three
    
    @IBOutlet weak var interestsCollectionView: UICollectionView!
    @IBOutlet weak var interestsTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definePageType()
        genderTF.convertToPicker(options: ["", "ذكر", "أنثى"])
        cityTF.convertToPicker(options: ["", "جدة", "الرياض", "الدمام", "المدينة", "ينبع"])
        schoolTF.convertToPicker(options: ["", "شباب الفهد", "الأقصى", "الأندلس", "الحمدانية", "سعدية معاذ"])
        levelTF.convertToPicker(options: ["", "أولى ثانوي", "ثاني ثانوي", "ثالث ثانوي"])
        self.hideKeyboardWhenTappedAround()
    }
    
    func definePageType() {
        guard let student = Student.currentStudent else {return}
        if mode == .editProfile {
            titleLabel.text = "تعديل الحساب"
            nameTF.text = student.name
            genderTF.text = student.gender
            phoneNumberTF.text = student.phoneNumber
            emailTF.text = student.email
            passwordStackView.isHidden = true
            cityTF.text = student.city
            schoolTF.text = student.school
            levelTF.text = student.level
            mapInformation.text = student.location
            
            
        } else {
            titleLabel.text = "إنشاء الحساب"
        }
    }
    
    
    //MARK: - IBOutleats
    
    @IBAction func didPressedCancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func backBTN(_ sender: UIButton) {
        if stepNumber > 0 {
            stepNumber -= 1
        }
        updateStepsUI()
    }
    
    @IBAction func didPressedNext(_ sender: UIButton) {
        validInformation()
    }
    
    @IBAction func openGoogleMap(_ sender: UIButton) {
        if let mapVC = storyboard?.instantiateViewController(identifier: "MapVC") as? MapVC {
            mapVC.delegate = self
            present(mapVC, animated: true, completion: nil)
        }
    }
    
    //MARK: - Functions
    
    func didSelectData(_ data: String) {
        mapInformation.text = data
    }
    
    
    func updateStepsUI() {
        func configureContainers(widthConstant: CGFloat, alphaOne: CGFloat, alphaTwo: CGFloat, alphaThree: CGFloat) {
            UIView.animate(withDuration: 0.2) {
                self.widthPar.constant = widthConstant
                
                self.informationUserView.alpha = alphaOne
                self.informationUserView.isHidden = alphaOne == 0
                
                self.informationSchoolView.alpha = alphaTwo
                self.informationSchoolView.isHidden = alphaTwo == 0
                
                self.interestsCollectionView.alpha = alphaThree
                self.interestsCollectionView.isHidden = alphaThree == 0
                self.interestsTitle.alpha = alphaThree
                self.interestsTitle.isHidden = alphaThree == 0
                self.loadViewIfNeeded()
                
            }
        }
        
        switch stepNumber {
        case 0:
            configureContainers(widthConstant: 300, alphaOne: 1, alphaTwo: 0, alphaThree: 0)
            self.backBTN.isHidden = true // Hide back button on first step
            nextBTN.isEnabled = true
            
        case 1:
            configureContainers(widthConstant: 150, alphaOne: 0, alphaTwo: 1, alphaThree: 0)
            nextBTN.setTitle("التالي", for: .normal)
            self.backBTN.isHidden = false // Show back button
            nextBTN.isEnabled = true
            
        case 2:
            configureContainers(widthConstant: 0, alphaOne: 0, alphaTwo: 0, alphaThree: 1)
            if mode == .register {
                nextBTN.setTitle("إنشاء", for: .normal)
            } else {
                nextBTN.setTitle("تعديل", for: .normal)
            }
            nextBTN.isEnabled = true
            
        default:
            let loadView = MessageView(message: "يرجى الإنتظار", animationName: "loading")
            loadView.show(in: self.view)
            nextBTN.isEnabled = false
        }
    }
    
    func validInformation() {
        // Only proceed with the validations if the current step is valid
        switch stepNumber {
        case 0:
            // Check all conditions before incrementing stepNumber
            var allValid = true // Track if all validations are successful
            
            if !nameTF.text!.isValidFullName() {
                let errorView = MessageView(message: "الاسم غير صحيح او غير مكتمل، يرجى إدخال الإسم الثلاثي", animationName: "warning")
                errorView.show(in: self.view)
                allValid = false
            } else if genderTF.text!.isEmpty {
                let errorView = MessageView(message: "يرجى اختيار الجنس", animationName: "warning")
                errorView.show(in: self.view)
                allValid = false
            } else if !phoneNumberTF.text!.isValidPhoneNumber() {
                let errorView = MessageView(message: "رقم الهاتف غير مكتمل او غير صحيح، يجب أن يبدأ ب 05", animationName: "warning")
                errorView.show(in: self.view)
                allValid = false
            } else if !emailTF.text!.isValidEmail() {
                let errorView = MessageView(message: "البريد الإلكتروني غير صحيح", animationName: "warning")
                errorView.show(in: self.view)
                allValid = false
            } else if passwordTF.text!.count < 6 && mode == .register {
                let errorView = MessageView(message: "كلمة المرور غير صحيحة، يجب ان تحتوي على 6 او أكثر", animationName: "warning")
                errorView.show(in: self.view)
                allValid = false
            }
            
            // Only increment stepNumber if all validations are successful
            if allValid {
                stepNumber += 1
                updateStepsUI()
            }
            
        case 1:
            // Example validation for step 1 (add your conditions)
            if cityTF.text!.isEmpty {
                let errorView = MessageView(message: "يرجى إدخال المدينة", animationName: "warning")
                errorView.show(in: self.view)
                return // Do not increment
            }
            
            if schoolTF.text!.isEmpty {
                let errorView = MessageView(message: "يرجى إدخال المدرسة", animationName: "warning")
                errorView.show(in: self.view)
                return // Do not increment
            }
            
            if levelTF.text!.isEmpty {
                let errorView = MessageView(message: "يرجى إدخال المستوى", animationName: "warning")
                errorView.show(in: self.view)
                return // Do not increment
            }
            
            if mapInformation.text == "معلومات الموقع" {
                let errorView = MessageView(message: "يرجى تحديد موقعك الحالي", animationName: "warning")
                errorView.show(in: self.view)
                return // Do not increment
            }
            
            // Proceed to next step only if all fields are filled in step 1
            stepNumber += 1
            updateStepsUI()
            
        case 2:
            if selectedInterestsType.count < 1 {
                let errorView = MessageView(message:" عليك إختيار اهتماماتك، على الأقل يجب إختيار واحدة", animationName: "warning")
                errorView.show(in: self.view)
                return // Do not increment
            } else {
                if mode == .register {
                    registerUser()
                } else {
                    self.dismiss(animated: true)
                }
            }
            stepNumber += 1
            updateStepsUI()
            
        default:
            print("validInformation")
        }
    }
    
    
    //MARK:- Register User
    
    private func registerUser() {
        AuthService.shared.registerUserWith(email: emailTF.text!, password: passwordTF.text!, name: nameTF.text!, phoneNumber: phoneNumberTF.text!, gender: genderTF.text!, city: cityTF.text!, school: schoolTF.text!, level: levelTF.text!, hoursCompleted: 0, location: mapInformation.text!, interests: selectedInterestsType, opportunities: []) { error in
            if error == nil {
                let successView = MessageView(message: "تم تسجيلك بنجاح، سيتم نقلك للصفحة الرئيسية بعد لحظات", animationName: "correct")
                successView.show(in: self.view)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                    self.coordinator?.viewNavigationVC()
                    self.dismiss(animated: true)
                }
            } else {
                let errorView = MessageView(message: "عملية التسجيل غير ناجحة، يرجى إعادة المحاولة مرة اخرى", animationName: "warning")
                errorView.show(in: self.view)
            }
        }
        
    }
    
    //MARK:- Update User
    
    private func updateUser() {
        
//        DataServices.shared.updateStudentAccount(studentID: Student.currentID, updatedData: <#T##[String : Any]#>)
        
    }
    
}

extension StudentAccountVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestsType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestsCell", for: indexPath) as! InterestsCell
        let interestType = interestsType[indexPath.row]
        
        // Configure the cell
        cell.config(type: interestType.rawValue, color: selectedIndexPaths.contains(indexPath) ? UIColor(named: "standr")! : .systemGray5)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 95, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = selectedIndexPaths.firstIndex(of: indexPath) {
            // Cell is already selected, treat as double tap to deselect
            selectedIndexPaths.remove(at: index)
            selectedInterestsType.remove(at: index) // Remove the corresponding interest type
            collectionView.reloadItems(at: [indexPath]) // Reload to change the color back
        } else {
            // If less than 3 cells are selected, allow selection
            if selectedIndexPaths.count < 3 {
                selectedIndexPaths.append(indexPath)
                selectedInterestsType.append(interestsType[indexPath.row])
                collectionView.reloadItems(at: [indexPath]) // Reload to change color
            } else {
                // Optionally show an alert or notification that the limit has been reached
                print("Maximum selection limit reached. You can only select up to 3 items.")
            }
        }
    }

    
}


//private func updateUser() {
//    // Ensure that we have the currently saved student
//    guard let currentStudent = Student.currentStudent else {
//        print("No local student found.")
//        return
//    }
//
//    // Gather current form input values
//    let updatedName = nameTF.text ?? ""
//    let updatedGender = genderTF.text ?? ""
//    let updatedPhoneNumber = phoneNumberTF.text ?? ""
//    let updatedEmail = emailTF.text ?? ""
//    let updatedCity = cityTF.text ?? ""
//    let updatedSchool = schoolTF.text ?? ""
//    let updatedLevel = levelTF.text ?? ""
//    let updatedLocation = mapInformation.text ?? ""
//
//    // Check if any of the fields have changed
//    var updatedData: [String: Any] = [:]
//
//    if updatedName != currentStudent.name {
//        updatedData["name"] = updatedName
//    }
//
//    if updatedGender != currentStudent.gender {
//        updatedData["gender"] = updatedGender
//    }
//
//    if updatedPhoneNumber != currentStudent.phoneNumber {
//        updatedData["phoneNumber"] = updatedPhoneNumber
//    }
//
//    if updatedEmail != currentStudent.email {
//        updatedData["email"] = updatedEmail
//    }
//
//    if updatedCity != currentStudent.city {
//        updatedData["city"] = updatedCity
//    }
//
//    if updatedSchool != currentStudent.school {
//        updatedData["school"] = updatedSchool
//    }
//
//    if updatedLevel != currentStudent.level {
//        updatedData["level"] = updatedLevel
//    }
//
//    if updatedLocation != currentStudent.location {
//        updatedData["location"] = updatedLocation
//    }
//
//    // If there is no change, show a message and return
//    if updatedData.isEmpty {
//        print("No changes detected.")
//        let messageView = MessageView(message: "لا توجد تغييرات لتحديثها", animationName: "info")
//        messageView.show(in: self.view)
//        return
//    }
//
//    // Proceed to update only if changes are detected
//    guard let currentUser = Auth.auth().currentUser else {
//        print("No user logged in.")
//        return
//    }
//
//    // 1. Update Email in Firebase Authentication, if changed
//    let updateGroup = DispatchGroup()
//
//    if let newEmail = updatedData["email"] as? String, newEmail != currentStudent.email {
//        updateGroup.enter()
//        currentUser.updateEmail(to: newEmail) { error in
//            if let error = error {
//                print("Error updating email: \(error.localizedDescription)")
//            } else {
//                print("Email updated successfully.")
//            }
//            updateGroup.leave()
//        }
//    }
//
//    // 2. Update Firestore with other profile fields (except email)
//    updateGroup.enter()
//    FirestoreReference(.schools).document(currentStudent.school)
//        .collection("students").document(currentUser.uid)
//        .updateData(updatedData) { error in
//            if let error = error {
//                print("Error updating student data: \(error.localizedDescription)")
//            } else {
//                print("Student data successfully updated.")
//            }
//            updateGroup.leave()
//        }
//
//    // 3. Show Success/Failure Message After All Updates
//    updateGroup.notify(queue: .main) {
//        let successView = MessageView(message: "تم تحديث بياناتك بنجاح", animationName: "correct")
//        successView.show(in: self.view)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
//            self.coordinator?.viewNavigationVC()
//            self.dismiss(animated: true)
//        }
//    }
//}
//

//private func updateUser() {
//    // Ensure that we have the currently saved student
//    guard let currentStudent = Student.currentStudent else {
//        print("No local student found.")
//        return
//    }
//
//    // Gather current form input values
//    let updatedName = nameTF.text ?? ""
//    let updatedGender = genderTF.text ?? ""
//    let updatedPhoneNumber = phoneNumberTF.text ?? ""
//    let updatedEmail = emailTF.text ?? ""
//    let updatedCity = cityTF.text ?? ""
//    let updatedSchool = schoolTF.text ?? ""
//    let updatedLevel = levelTF.text ?? ""
//    let updatedLocation = mapInformation.text ?? ""
//
//    // Create a new Student object with the updated values
//    var updatedStudent = currentStudent
//
//    var hasChanges = false
//
//    if updatedName != currentStudent.name {
//        updatedStudent.name = updatedName
//        hasChanges = true
//    }
//
//    if updatedGender != currentStudent.gender {
//        updatedStudent.gender = updatedGender
//        hasChanges = true
//    }
//
//    if updatedPhoneNumber != currentStudent.phoneNumber {
//        updatedStudent.phoneNumber = updatedPhoneNumber
//        hasChanges = true
//    }
//
//    if updatedEmail != currentStudent.email {
//        updatedStudent.email = updatedEmail
//        hasChanges = true
//    }
//
//    if updatedCity != currentStudent.city {
//        updatedStudent.city = updatedCity
//        hasChanges = true
//    }
//
//    if updatedSchool != currentStudent.school {
//        updatedStudent.school = updatedSchool
//        hasChanges = true
//    }
//
//    if updatedLevel != currentStudent.level {
//        updatedStudent.level = updatedLevel
//        hasChanges = true
//    }
//
//    if updatedLocation != currentStudent.location {
//        updatedStudent.location = updatedLocation
//        hasChanges = true
//    }
//
//    // If there is no change, show a message and return
//    if !hasChanges {
//        print("No changes detected.")
//        let messageView = MessageView(message: "لا توجد تغييرات لتحديثها", animationName: "info")
//        messageView.show(in: self.view)
//        return
//    }
//
//    // Proceed to update only if changes are detected
//    guard let currentUser = Auth.auth().currentUser else {
//        print("No user logged in.")
//        return
//    }
//
//    // 1. Update Email in Firebase Authentication, if changed
//    let updateGroup = DispatchGroup()
//
//    if updatedStudent.email != currentStudent.email {
//        updateGroup.enter()
//        currentUser.updateEmail(to: updatedStudent.email) { error in
//            if let error = error {
//                print("Error updating email: \(error.localizedDescription)")
//            } else {
//                print("Email updated successfully.")
//            }
//            updateGroup.leave()
//        }
//    }
//
//    // 2. Update Firestore with the new Student object
//    updateGroup.enter()
//    do {
//        try FirestoreReference(.schools).document(updatedStudent.school)
//            .collection("students").document(currentUser.uid)
//            .setData(from: updatedStudent) { error in
//                if let error = error {
//                    print("Error updating student data: \(error.localizedDescription)")
//                } else {
//                    print("Student data successfully updated.")
//                }
//                updateGroup.leave()
//            }
//    } catch {
//        print("Error encoding student data: \(error.localizedDescription)")
//        updateGroup.leave()
//    }
//
//    // 3. Show Success/Failure Message After All Updates
//    updateGroup.notify(queue: .main) {
//        let successView = MessageView(message: "تم تحديث بياناتك بنجاح", animationName: "correct")
//        successView.show(in: self.view)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
//            self.coordinator?.viewNavigationVC()
//            self.dismiss(animated: true)
//        }
//    }
//}
