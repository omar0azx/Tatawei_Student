//
//  StudentDataServices.swift
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
    case opportunities
}



func FirestoreReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}

class StudentDataServices {
    
    static let shared = StudentDataServices()
    
    func saveUserToFirestore(_ user: Student) {
        do {
            
            try FirestoreReference(.schools).document(user.school).collection("students").document(user.id).setData(from: user)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    // MARK: - Download User from Firestore
    func getStudentByCollectionGroup(studentID: String) {
        
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
    
    func getStudentData(schoolID: String, studentID: String, completion: @escaping (_ status: Bool?, _ error: Error?) -> Void) {
        // Reference to the Firestore collection where students are stored
        let studentRef = FirestoreReference(.schools).document(schoolID).collection("students").document(studentID)
        
        studentRef.getDocument { (document, error) in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let document = document, document.exists else {
                completion(false, nil) // No document found
                return
            }
            
            // Try to decode the document data into a Student struct
            do {
                
                let student = try document.data(as: Student.self)
                
                saveUserLocally(student)
                print("Student found and saved locally: \(student)")
                
                completion(true, nil)
                
            } catch {
                
                print("Error decoding student data: \(error.localizedDescription)")
                
                completion(false, error)
            }
        }
    }
    
    
    func updateStudentAccount(updatedData: Student, completion: @escaping (_ error: Error?) -> Void) {
        // Get reference to the student's document in Firestore
        let studentRef = FirestoreReference(.schools).document(Student.currentStudent!.school)
            .collection("students").document(Student.currentID)
        
        studentRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data(), let hoursCompleted = data["hoursCompleted"] as? Float, let isStudentAccepted = data["isStudentAccepted"] as? Int, let studrntOpportunity = data["opportunities"] as? [String], let badges = data["badges"] as? [String: Int] {
                    
                    var updatedStudent = updatedData
                    updatedStudent.hoursCompleted = hoursCompleted
                    updatedStudent.isStudentAccepted = isStudentAccepted
                    updatedStudent.opportunities = studrntOpportunity
                    updatedStudent.badges = badges
                    
                    // Convert updatedStudent to a dictionary using JSONEncoder
                    do {
                        let jsonData = try JSONEncoder().encode(updatedStudent)
                        if let updatedStudentDict = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] {
                            // Update Firestore with the new values
                            studentRef.updateData(updatedStudentDict) { error in
                                if let error = error {
                                    print("Error updating student data: \(error.localizedDescription)")
                                    completion(error)
                                } else {
                                    
                                    saveUserLocally(updatedStudent)
                                    print("Student data successfully updated.")
                                    completion(nil)
                                }
                            }
                        }
                    } catch {
                        print("Error encoding student data: \(error.localizedDescription)")
                        completion(error)
                    }
                } else {
                    print("Error fetching hoursCompleted value: \(error?.localizedDescription ?? "Unknown error")")
                    completion(error)
                }
                
            } else {
                print("Document does not exist or error fetching document: \(error?.localizedDescription ?? "Unknown error")")
                completion(error)
            }
        }
    }
    
    func updateStudentHours(additionalHours: Float, completion: @escaping (_ error: Error?) -> Void) {
        // Get reference to the student's document in Firestore
        let studentRef = FirestoreReference(.schools).document(Student.currentStudent!.school)
            .collection("students").document(Student.currentID)
        
        studentRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data(), let currentHoursCompleted = data["hoursCompleted"] as? Float {
                    
                    let updatedHoursCompleted = currentHoursCompleted + additionalHours // Add the additional hours
                    
                    // Update Firestore with the new hoursCompleted value
                    studentRef.updateData(["hoursCompleted": updatedHoursCompleted]) { error in
                        if let error = error {
                            print("Error updating hoursCompleted: \(error.localizedDescription)")
                            completion(error)
                        } else {
                            // Optionally update the locally saved student data
                            if var currentStudent = Student.currentStudent {
                                currentStudent.hoursCompleted = updatedHoursCompleted
                                saveUserLocally(currentStudent)
                            }
                            print("hoursCompleted successfully updated to: \(updatedHoursCompleted)")
                            completion(nil)
                        }
                    }
                } else {
                    print("Error fetching hoursCompleted value: \(error?.localizedDescription ?? "Unknown error")")
                    completion(error)
                }
            } else {
                print("Document does not exist or error fetching document: \(error?.localizedDescription ?? "Unknown error")")
                completion(error)
            }
        }
    }
    
    
    
    
    
    //MARK:- Download users using IDs
    
    func downloadStudentFromFirestore(withIds: [String], schoolID: String, completion: @escaping(_ allUsers: [Student])->Void) {
        
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
    func downloadAllStudentsFromFirestore(schoolID: String, completion: @escaping (_ allUsers: [Student])->Void) {
        
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

