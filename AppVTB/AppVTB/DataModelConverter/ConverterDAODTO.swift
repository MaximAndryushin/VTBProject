//
//  File.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 01.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import Foundation

protocol ConverterDAODTO {
    associatedtype DAO
    associatedtype DTO
    
    static func DAOtoDTO(_ object: DAO) -> DTO
    static func DTOtoDAO(_ object: DTO) -> DAO
}


// MARK: - Phone Converter
struct PhoneConverter: ConverterDAODTO {
    static func DAOtoDTO(_ object: PhoneNumber) -> NumberAPIModel {
        return NumberAPIModel.init(
            valid: object.valid,
            number: object.number!,
            countryPrefix: object.countryPrefix!,
            countryCode: object.countryCode!,
            countryName: object.countryName!,
            location: object.location!,
            carrier: object.carrier!,
            lineType: object.lineType!
        )
    }
    
    static func DTOtoDAO(_ object: NumberAPIModel) -> PhoneNumber {
        return PhoneNumber()
    }
}


//MARK: - Breach DTO
struct BreachDTO: Hashable {
    let name: String
    let domain: String
    let addedDate: Date
    let modifiedDate: Date
    let info: String
    let logoPath: String
}

struct BreachConverter: ConverterDAODTO {
    static func DAOtoDTO(_ object: Breach) -> BreachDTO {
        return BreachDTO(
            name: object.name!,
            domain: object.domain!,
            addedDate: object.addedDate!,
            modifiedDate: object.modifiedDate!,
            info: object.info!,
            logoPath: object.logoPath!
        )
    }
    
    static func DTOtoDAO(_ object: BreachDTO) -> Breach {
        return Breach()
    }
    
}


// MARK: - Email DTO
struct EmailDTO {
    let email: String
    let isValid: Bool
    let reason: String
    let isDisposable: Bool
    let role: Bool
    let isFree: Bool
    let safeToSend: Bool
    let domain: String
    let user: String
    let isVerified: Bool
    let isSpamList: String
    let isRetired: Bool
    let isFabricated: Bool
    let breaches: [BreachDTO]
}


// MARK: - Email Converter
struct EmailConverter: ConverterDAODTO {
    static func DAOtoDTO(_ object: Email) -> EmailDTO {
        return EmailDTO(
            email: object.email!,
            isValid: object.isValid,
            reason: object.reason!,
            isDisposable: object.isDisposable,
            role: object.role,
            isFree: object.isFree,
            safeToSend: object.safeToSend,
            domain: object.domain!,
            user: object.user!,
            isVerified: object.isVerified,
            isSpamList: object.isSpamList!,
            isRetired: object.isRetired,
            isFabricated: object.isFabricated,
            breaches: (object.breaches?.sortedArray(using: []).map({return BreachConverter.DAOtoDTO($0 as! Breach)}))!
        )
    }
    
    static func DTOtoDAO(_ object: EmailDTO) -> Email {
        return Email()
    }
}

