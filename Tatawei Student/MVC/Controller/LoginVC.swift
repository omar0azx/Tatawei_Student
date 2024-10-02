//
//  LoginVC.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 24/03/1446 AH.
//

import UIKit

class LoginVC: UIViewController, Storyboarded {
    
    
    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    
    //MARK: - IBOutleats
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var emailTF: DesignableTextField!
    @IBOutlet weak var passwordTF: DesignableTextField!
    @IBOutlet weak var passwordStackView: UIStackView!
    
    @IBOutlet weak var forgetPassword: UIButton!
    
    @IBOutlet weak var loginBTN: DesignableButton!
    
    @IBOutlet weak var createAccountStackView: UIStackView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - IBAcitions
    
    @IBAction func forgetPassword(_ sender: UIButton) {
        forgetPassword.titleLabel?.font = UIFont(name: "Cairo", size: 13)
        loginBTN.titleLabel?.font = UIFont(name: "Cairo", size: 18)
        if forgetPassword.titleLabel?.text == "نسيت كلمة المرور ؟" {
            updateUI(title: "إسترجاع كلمة المرور", passwordHidden: true, forgetPasswordTitle: "لدي حساب بالفعل !", loginButtonTitle: "إرسال", createAccountHidden: true)
        } else {
            updateUI(title: "تسجيل الدخول", passwordHidden: false, forgetPasswordTitle: "نسيت كلمة المرور ؟", loginButtonTitle: "دخول", createAccountHidden: false)
        }
    }
    
    @IBAction func loginBTN(_ sender: UIButton) {
        
        if loginBTN.titleLabel?.text == "إرسال" {
            if !emailTF.text!.isValidEmail() {
                let errorView = MessageView(message: "البريد الإلكتروني غير صحيح", animationName: "warning")
                errorView.show(in: self.view)
                return
            }
            AuthService.shared.resetPasswordFor(email: emailTF.text!) { error in
                if error == nil {
                    self.coordinator?.viewforgetPasswordVC(animation: true)
                    self.updateUI(title: "تسجيل الدخول", passwordHidden: false, forgetPasswordTitle: "نسيت كلمة المرور ؟", loginButtonTitle: "دخول", createAccountHidden: false)
                } else {
                    print("لم يتم إرسال رابط إرسال تغيير كلمة المرور، تحقق من بريدك")
                    let errorView = MessageView(message: "لم يتم إرسال رابط إرسال تغيير كلمة المرور، تحقق من بريدك", animationName: "warning")
                    errorView.show(in: self.view)
                }
            }
        } else {
            if !emailTF.text!.isValidEmail() {
                let errorView = MessageView(message: "البريد الإلكتروني غير صحيح", animationName: "warning")
                errorView.show(in: self.view)
                return
            } else if passwordTF.text!.count < 6 {
                let errorView = MessageView(message: "كلمة المرور غير صحيحة، يجب ان تحتوي على 6 او أكثر", animationName: "warning")
                errorView.show(in: self.view)
                return
            }
            signIn()
        }
        
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        coordinator?.viewRegisterVC()
    }
    
    
    //MARK: - Functions
    
    func updateUI(title: String, passwordHidden: Bool, forgetPasswordTitle: String, loginButtonTitle: String, createAccountHidden: Bool) {
        titleLabel.text = title
        passwordStackView.isHidden = passwordHidden
        forgetPassword.setTitle(forgetPasswordTitle, for: .normal)
        loginBTN.setTitle(loginButtonTitle, for: .normal)
        createAccountStackView.isHidden = createAccountHidden
    }
    
    //MARK:- Login User
    
    private func signIn() {
        let loadView = MessageView(message: "يرجى الإنتظار", animationName: "loading")
        loadView.show(in: self.view)
        AuthService.shared.loginUser(withEmail: emailTF.text!, andPassword: passwordTF.text!) { status, error in
            if status {
                let successView = MessageView(message: "تم تسجيلك بنجاح، سيتم نقلك للصفحة الرئيسية بعد لحظات", animationName: "correct")
                successView.show(in: self.view)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                    self.coordinator?.backNav()
                    self.dismiss(animated: true)
                }
            } else {
                let errorView = MessageView(message: "فشل عملية تسجيل الدخول، تحقق من بريدك وكلمة المرور", animationName: "warning")
                errorView.show(in: self.view)
            }
        }
    }
    

}
