//
//  EmailPasswordAPIModel.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

//MARK: - Response Model
struct Breach: Codable {
    let name, title, domain, breachDate: String
    let addedDate, modifiedDate: String
    let pwnCount: Int
    let breachDescription: String
    let logoPath: String
    let dataClasses: [String]
    let isVerified, isFabricated, isSensitive, isRetired: Bool
    let isSpamList: Bool
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case title = "Title"
        case domain = "Domain"
        case breachDate = "BreachDate"
        case addedDate = "AddedDate"
        case modifiedDate = "ModifiedDate"
        case pwnCount = "PwnCount"
        case breachDescription = "Description"
        case logoPath = "LogoPath"
        case dataClasses = "DataClasses"
        case isVerified = "IsVerified"
        case isFabricated = "IsFabricated"
        case isSensitive = "IsSensitive"
        case isRetired = "IsRetired"
        case isSpamList = "IsSpamList"
    }
}

typealias EmailPasswordsAPIResponse = [Breach]
