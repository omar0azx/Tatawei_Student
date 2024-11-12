//
//  opportunities.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 15/04/1446 AH.
//

import Foundation

enum OpportunityStatus: String, Codable {
    case open = "open"
    case inProgress = "in progress"
    case finished = "finished"
}

struct Opportunity: Codable {
    
    var id: String
    var name: String
    var description: String
    var date: String
    var time: String
    var hour: Int
    var city: Cities
    var status: OpportunityStatus
    var category: InterestCategories
    var iconNumber: Int
    var location: String
    var latitude: Double
    var longitude: Double
    var studentsNumber: Int
    var organizationID: String
    var organizationName: String
    var isAccepted: Bool?
    
    var formattedDate: Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd" // Use your date format here
            return dateFormatter.date(from: date)
        }
    
    static var currentOpportunity: Opportunity? {
        if let data = UserDefaults.standard.data(forKey: kCURRENTOPPORTUNITY) {
            let decoder = JSONDecoder()
            do {
                let opportunityObject = try decoder.decode(Opportunity.self, from: data)
                return opportunityObject
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

func saveOpportunityLocally(_ opportunity: Opportunity) {
    let encoder = JSONEncoder()
    do {
        let data = try encoder.encode(opportunity)
        UserDefaults.standard.set(data, forKey: kCURRENTOPPORTUNITY)

    } catch {
        print(error.localizedDescription)
    }
}
