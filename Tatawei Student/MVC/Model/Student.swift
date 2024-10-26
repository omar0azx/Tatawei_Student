//
//  Students.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 23/03/1446 AH.
//

import Foundation
import FirebaseAuth

enum Gender: String, Codable {
    case male = "ذكر"
    case female = "انثى"
}
 
struct Student: Codable {
    
    var id: String
    var name: String
    var phoneNumber: String
    var email: String
    var gender: Gender
    var city: String
    var school: String
    var level: String
    var hoursCompleted: Float
    var location: String
    var interests: [InterestCategories]
    var opportunities: [String]
    
    static var currentID: String {
        return Auth.auth().currentUser!.uid
    }
    
    static var currentStudent: Student? {
        
        if Auth.auth().currentUser != nil {
            if let data = UserDefaults.standard.data(forKey: "currentStudent") {
                let decoder = JSONDecoder()
                do {
                    let userObject = try decoder.decode(Student.self, from: data)
                    return userObject
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        }
        return nil
    }
}

func saveUserLocally(_ user: Student) {
    let encoder = JSONEncoder()
    do {
        let data = try encoder.encode(user)
        UserDefaults.standard.set(data, forKey: "currentStudent")
    } catch {
        print(error.localizedDescription)
    }
}
