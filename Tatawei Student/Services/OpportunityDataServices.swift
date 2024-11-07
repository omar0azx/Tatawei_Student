//
//  OpportunityDataServices.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 19/04/1446 AH.
//

import Foundation
import FirebaseFirestore

class OpportunityDataServices {
    
    static let shared = OpportunityDataServices()

        private let db = Firestore.firestore()
        private var lastDocumentSnapshot: DocumentSnapshot?

    func downloadOpportunitiesFromFirestore(limit: Int, completion: @escaping ([Opportunity]?, Error?) -> Void) {
        var query: Query = db.collectionGroup("opportunities").whereField("status", isEqualTo: OpportunityStatus.open.rawValue).limit(to: limit)
           if let lastSnapshot = lastDocumentSnapshot {
               query = query.start(afterDocument: lastSnapshot)
           }
           query.getDocuments { (snapshot, error) in
               if let error = error {
                   completion(nil, error)
                   return
               }
               guard let snapshot = snapshot else {
                   completion([], nil)
                   return
               }
               // If no documents are returned, there's no more data to load
               if snapshot.documents.isEmpty {
                   completion([], nil)
                   return
               }
               // Store the last document snapshot for pagination
               self.lastDocumentSnapshot = snapshot.documents.last
               // Convert documents to Opportunity objects
               let opportunities: [Opportunity] = snapshot.documents.compactMap { document in
                   try? document.data(as: Opportunity.self)
               }
               completion(opportunities, nil)
           }
    }
    
    func applyToOpportunity(studentID: String, opportunity: Opportunity, completion: @escaping (_ status: Bool, _ error: Error?) -> Void) {
        let studentRef = FirestoreReference(.schools).document(Student.currentStudent!.school)
            .collection("students").document(Student.currentID)
        let opportunityRef = FirestoreReference(.organisations).document(opportunity.organizationID)
            .collection("opportunities").document(opportunity.id)
            .collection("studentOpportunity").document(studentID) // Now it's a DocumentReference

        updateOpportunityRegistration(opportunityRef: opportunityRef, studentID: studentID) { status, error in
            if let error = error {
                completion(false, error)
                return
            }
            if status {
                self.updateStudentOpportunities(studentRef: studentRef, opportunityID: opportunity.id) { status, error in
                    completion(status, error)
                }
            } else {
                completion(false, nil)
            }
        }
    }
    
    func cancelOpportunityRegistration(studentID: String, opportunity: Opportunity, completion: @escaping (_ status: Bool, _ error: Error?) -> Void) {
        // Reference to the specific student document within the studentOpportunity collection
        let opportunityRef = FirestoreReference(.organisations).document(opportunity.organizationID)
            .collection("opportunities").document(opportunity.id)
            .collection("studentOpportunity").document(studentID)
        
        let studentRef = FirestoreReference(.schools).document(Student.currentStudent!.school)
            .collection("students").document(Student.currentID)
        
        studentRef.updateData([
            "opportunities": FieldValue.arrayRemove([opportunity.id])
            ]) { error in
                if let error = error {
                    // An error occurred during the update
                    completion(false, error)
                } else {
                    // Successfully removed the opportunity ID
                    completion(true, nil)
                }
            }
        
        // Delete the student's document from studentOpportunity
        opportunityRef.delete { error in
            if let error = error {
                // An error occurred while deleting
                completion(false, error)
                return
            }
            // Successfully deleted
            completion(true, nil)
        }
    }

    private func updateOpportunityRegistration(opportunityRef: DocumentReference, studentID: String, completion: @escaping (_ status: Bool, _ error: Error?) -> Void) {

        opportunityRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print("Student ID already registered in opportunity.")
                completion(false, nil)
            } else {
                // Set the 'isAccepted' field only for this student
                opportunityRef.setData(["isAccepted": false]) { error in
                    if let error = error {
                        print("Error registering student in opportunity: \(error)")
                        completion(false, error)
                    } else {
                        print("Student successfully registered in opportunity!")
                        completion(true, nil)
                    }
                }
            }
        }
    }


    private func updateStudentOpportunities(studentRef: DocumentReference, opportunityID: String, completion: @escaping (_ status: Bool, _ error: Error?) -> Void) {
        studentRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var opportunities = document.get("opportunities") as? [String] ?? []
                
                if !opportunities.contains(opportunityID) {
                    opportunities.append(opportunityID)
                    studentRef.updateData(["opportunities": opportunities]) { error in
                        if let error = error {
                            print("Error updating student opportunities: \(error)")
                            completion(false, error)
                        } else {
                            print("Opportunity successfully added to student record!")
                            completion(true, nil)
                        }
                    }
                } else {
                    print("Opportunity ID already added.")
                    completion(false, nil)
                }
            } else {
                print("Error fetching student document: \(String(describing: error))")
                completion(false, error)
            }
        }
    }
    
    func getStudentOpportunities(opportunityIDs: [String], completion: @escaping (_ opportunities: [Opportunity], _ error: Error?) -> Void) {
        guard !opportunityIDs.isEmpty else {
            completion([], nil)
            return
        }
        
        let db = Firestore.firestore()
        var opportunityDict: [String: Opportunity] = [:] // Dictionary to store opportunities by ID
        let dispatchGroup = DispatchGroup()

        for opportunityID in opportunityIDs {
            dispatchGroup.enter()
            db.collectionGroup("opportunities")
                .whereField("id", isEqualTo: opportunityID)
                .getDocuments { (snapshot, error) in
                    if let error = error {
                        dispatchGroup.leave()
                        completion([], error)
                        return
                    }

                    for document in snapshot?.documents ?? [] {
                        do {
                            var opportunity = try Firestore.Decoder().decode(Opportunity.self, from: document.data())
                            
                            // Fetching acceptance status from the sub-collection
                            document.reference.collection("studentOpportunity").document(Student.currentID).getDocument { (studentDoc, error) in
                                if error == nil {
                                    opportunity.isAccepted = studentDoc?.data()?["isAccepted"] as? Bool ?? false
                                } else {
                                    opportunity.isAccepted = false // Default if not registered
                                }
                                // Add to dictionary using opportunity ID as the key
                                opportunityDict[opportunityID] = opportunity
                                dispatchGroup.leave()
                            }
                        } catch {
                            print("Error decoding opportunity: \(error)")
                            dispatchGroup.leave()
                        }
                    }
                }
        }

        dispatchGroup.notify(queue: .main) {
            // Map the dictionary back to an array in the original order of opportunityIDs
            let orderedOpportunities = opportunityIDs.compactMap { opportunityDict[$0] }
            completion(orderedOpportunities, nil)
        }
    }


    func getOrganisationData(organisationID: String, completion: @escaping(_ organisation: Organization?) -> Void) {
        
        // Reference to Firestore collection
        FirestoreReference(.organisations).document(organisationID).getDocument { (document, error) in
            
            // Check if the document exists
            if let document = document, document.exists {
                do {
                    // Try to decode the document into the Organization model
                    let organisation = try document.data(as: Organization.self)
                    print("Organisation: \(organisation)")
                    completion(organisation) // Call completion with the decoded organization
                } catch {
                    // Handle decoding errors
                    print("Error decoding document into Organization: \(error)")
                    completion(nil) // Call completion with nil if decoding fails
                }
            } else {
                // Handle case where document does not exist or there is an error
                if let error = error {
                    print("Error fetching document: \(error.localizedDescription)")
                } else {
                    print("Document does not exist.")
                }
                completion(nil) // Call completion with nil if document does not exist
            }
        }
    }

    func updateOrganizationRating(organisationID: String, newRate: Int, completion: @escaping (_ status: Bool, _ error: Error?) -> Void) {
        let organizationRef = FirestoreReference(.organisations).document(organisationID)
        
        // Step 1: Fetch current rate and numberOfReviewers
        organizationRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let currentRate = document.get("rate") as? Double ?? 0
                let currentNumberOfReviewers = document.get("numberOfReviewers") as? Int ?? 0
                
                // Step 2: Increment numberOfReviewers by 1
                let updatedNumberOfReviewers = currentNumberOfReviewers + 1
                
                // Step 3: Calculate new average rate
                let updatedRate = (currentRate * Double(currentNumberOfReviewers) + Double(newRate)) / Double(updatedNumberOfReviewers)
                
                // Step 4: Update Firestore with new rate and incremented numberOfReviewers
                organizationRef.updateData([
                    "rate": updatedRate,
                    "numberOfReviewers": FieldValue.increment(Int64(1))
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        print("Error updating document: \(error)")
                    } else {
                        completion(true, nil)
                        print("Document successfully updated with new rate: \(updatedRate) and numberOfReviewers: \(updatedNumberOfReviewers)")
                    }
                }
                
            } else {
                completion(false, error)
                print("Document does not exist or there was an error fetching it: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }


}
