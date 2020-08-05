//
//  EmailPasswordAPIModel.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

//MARK: - Response Model
struct BreachAPI: Codable {
    let name: String
    let title: String
    let domain: String
    let breachDate: String
    let addedDate: String
    let modifiedDate: String
    let pwnCount: Int
    let breachDescription: String
    let logoPath: String
    let dataClasses: [String]
    let isVerified: Bool
    let isFabricated: Bool
    let isSensitive: Bool
    let isRetired: Bool
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

typealias EmailPasswordsAPIResponse = [BreachAPI]
