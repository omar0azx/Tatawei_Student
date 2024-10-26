//
//  opportunities.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 15/04/1446 AH.
//

import Foundation

struct Opportunity: Codable {
    
    var id: String
    var name: String
    var description: String
    var date: String
    var time: String
    var hour: Int
    var city: Cities
    var status: String
    var category: InterestCategories
    var iconNumber: Int
    var location: String
    var locationLink: String
    var studentsNumber: Int
    var registeredSudents: Int
    var organizationImageLink: String
    var organizationID: String
    var organizationName: String
    var studentRegisted: [String]
    var studentAccepted: [String]

}



