//
//  Organization.swift
//  Tatawei Student
//
//  Created by omar alzhrani on 15/04/1446 AH.
//

import Foundation

struct Organization: Codable {
    
    var id: String
    var name: String
    var email: String
    var phoneNumber: String
    var description: String
    var rate: Int
    var volunteersNumber: Int
    var organizationImageLink: String
//    var opportunities: [Opportunity]

}