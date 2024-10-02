//
//  AuthServices.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 23/03/1446 AH.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthService {
    
    static let shared = AuthService()
    
    private init () {}
    
    
    //MARK:- Register
    
    func registerUserWith(email: String, password: String, name: String, phoneNumber: String, gender: String, city: String, school: String, level: String, hoursCompleted: Int, location: String, interests: [InterestCategories], opportunities: [String], completion: @escaping (_ error: Error?) ->Void) {
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResults, error) in
            completion(error)
            
            if authResults?.user != nil {
                let student = Student(id: authResults!.user.uid, name: name, phoneNumber: phoneNumber, email: email, gender: gender, city: city, school: school, level: level, hoursCompleted: hoursCompleted, location: location, interests: interests, opportunities: opportunities)
                DataServices.shared.saveUserToFirestore(student)
                saveUserLocally(student)
                
            } else {
                
            }
            
        }
    }
    
    func loginUser(withEmail email: String , andPassword password: String , loginCompleat: @escaping (_ status: Bool , _ error: Error?) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginCompleat(false, error)
                return
            }
            loginCompleat(true, nil)
            
        }
    }
    
    //MARK:- Login
    
    func loginUserWith(withEmail email: String , andPassword password: String , loginCompleat: @escaping (_ status: Bool , _ error: Error?) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResults, error) in
            if error != nil {
                loginCompleat(false, error)
                return
            }
            DataServices.shared.downloadUserFromFirestore(studentID: authResults!.user.uid)
            loginCompleat(true, nil)
            
        }
    }
    
    
    //MARK:- Logout
    
    func logoutCurrentUser(completion: @escaping (_ error: Error?)-> Void) {
        
        do {
            try Auth.auth().signOut()
            userDefaults.removeObject(forKey: kCURRENTUSER)
            userDefaults.synchronize()
            completion(nil)
        } catch let error as NSError {
            
            completion(error)
        }
    }
    
    
    //MARK:- Reset password
    
    func resetPasswordFor(email: String, completion: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            completion(error)
        }
        
    }
    
    func deleteAccount(completion: @escaping (_ error: Error?) -> ()) {
        
        let user = Auth.auth().currentUser
        user?.delete { error in
            userDefaults.removeObject(forKey: kCURRENTUSER)
            userDefaults.synchronize()
            completion(error)
        }
        
    }
    
}

