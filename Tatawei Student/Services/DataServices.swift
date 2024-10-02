//
//  DataServices.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 23/03/1446 AH.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case schools
    case students
    case organisations
}


func FirestoreReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}

class DataServices {
    
    static let shared = DataServices()
    
    private init () {}
    
    func saveUserToFirestore(_ user: Student) {
        do {
            
            try FirestoreReference(.schools).document(user.school).collection("Students").document(user.id).setData(from: user)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    // MARK: - Download User from Firestore
    func downloadUserFromFirestore(studentID: String) {
        
        let db = Firestore.firestore()
        
        // Create a collection group query for the "students" subcollection
        let studentsQuery = db.collectionGroup("students").whereField("id", isEqualTo: studentID)
        
        // Execute the query
        studentsQuery.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching student data: \(error.localizedDescription)")
                return
            }
            
            // Check if any documents were returned
            guard let documents = querySnapshot?.documents, !documents.isEmpty else {
                print("Student with ID \(studentID) not found.")
                return
            }
            
            // Iterate through the results
            for document in documents {
                let studentData = document.data()
                print("Student found: \(studentData)")
            }
            
            let document = documents[0]  // Get the first document
            let studentData = document.data()  // Extract data as a dictionary
            
            // Convert the dictionary to JSON data
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: studentData, options: [])
                
                // Use JSONDecoder to decode the JSON data into a Student object
                let decoder = JSONDecoder()
                let student = try decoder.decode(Student.self, from: jsonData)
                
                // Save the student data locally
                saveUserLocally(student)
                print("Student found and saved locally: \(student)")
                
            } catch {
                print("Error decoding student data: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK:- Download users using IDs
    
    func downloadUsersFromFirestore(withIds: [String], schoolID: String, completion: @escaping(_ allUsers: [Student])->Void) {
        
        var count = 0
        var usersArray: [Student] = []
        
        for userID in withIds {
            
            FirestoreReference(.schools).document(schoolID).collection("students").document(userID).getDocument { (querySnapshot, error) in
                
                guard let document = querySnapshot else {
                    return
                }
                let user = try? document.data(as: Student.self)
                
                usersArray.append (user!)
                count+=1
                
                if count == withIds.count {
                    completion (usersArray)
                }
                
            }
        }
        
        
        
    }
    
    
    
    //MARK:- Download all users
    func downloadAllUsersFromFirestore(schoolID: String, completion: @escaping (_ allUsers: [Student])->Void) {
        
        var users: [Student] = []
        
        FirestoreReference(.schools).document(schoolID).collection("students").getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print ("No documents found")
                return
            }
            
            let allUsers = documents.compactMap { (snapshot) -> Student? in
                return try? snapshot.data(as: Student.self)
            }
            
            for user in allUsers {
                if Student.currentID != user.id {
                    users.append(user)
                }
            }
            
            completion(users)
            
        }
        
        
        
    }
    
}

