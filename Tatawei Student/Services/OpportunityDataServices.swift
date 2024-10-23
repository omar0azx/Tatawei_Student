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
           var query: Query = db.collectionGroup("opportunities").limit(to: limit)
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

    func fetchOrganisationData(organisationId: String, completion: @escaping(_ organisation: Organization?) -> Void) {
        
        // Reference to Firestore collection
        FirestoreReference(.organisations).document(organisationId).getDocument { (document, error) in
            
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



}
