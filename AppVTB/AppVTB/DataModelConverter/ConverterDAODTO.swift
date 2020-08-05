//
//  ConverterDAODTO.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 01.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import Foundation

// MARK: - NumberDTO
struct NumberDTO {
    let valid: Bool
    let number: String
    let countryPrefix: String
    let countryCode: String
    let countryName: String
    let location: String
    let carrier: String
    let lineType: String
    let date: Date
}

// MARK: - Phone Number DTO Converter
protocol NumberDTOConverter {
    func phoneNumberToNumberDTO(_ number: PhoneNumber) -> NumberDTO
    func numberDTOToPhoneNumber(_ number: NumberDTO) -> PhoneNumber
}

final class NumberConverter: NumberDTOConverter {
    func phoneNumberToNumberDTO(_ number: PhoneNumber) -> NumberDTO {
        return NumberDTO(
            valid: number.valid,
            number: number.number!,
            countryPrefix: number.countryPrefix!,
            countryCode: number.countryCode!,
            countryName: number.countryName!,
            location: number.location!,
            carrier: number.carrier!,
            lineType: number.lineType!,
            date: number.date!
        )
    }
    
    func numberDTOToPhoneNumber(_ number: NumberDTO) -> PhoneNumber {
        return PhoneNumber()
    }
    
}


//MARK: - Breach DTO
struct BreachDTO: Hashable {
    let name: String
    let domain: String
    let addedDate: String
    let modifiedDate: String
    let info: String
    let logoPath: String
}


// MARK: -Breach DTO Converter

protocol BreachDTOConverter {
    func breachToBreachDTO(_ breach: Breach) -> BreachDTO
    func breachDTOToBreach(_ breach: BreachDTO) -> Breach
}

final class BreachConverter: BreachDTOConverter {
    func breachToBreachDTO(_ breach: Breach) -> BreachDTO {
        return BreachDTO(
            name: breach.name!,
            domain: breach.domain!,
            addedDate: breach.addedDate!,
            modifiedDate: breach.modifiedDate!,
            info: breach.info!,
            logoPath: breach.logoPath!
        )
    }
    
    func breachDTOToBreach(_ breach: BreachDTO) -> Breach {
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
    let isSpamList: Bool
    let isRetired: Bool
    let isFabricated: Bool
    let breaches: [BreachDTO]
    let date: Date
}

// MARK: - Email DTO Converter

protocol EmailDTOConverter {
    func emailToEmailDTO(_ email: Email) -> EmailDTO
    func emailDTOToEmail(_ email: EmailDTO) -> Email
}

final class EmailConverter: EmailDTOConverter {
    
    let breachConverter: BreachDTOConverter
    
    init(converter: BreachDTOConverter) {
        self.breachConverter = converter
    }
    
    func emailToEmailDTO(_ email: Email) -> EmailDTO {
        return EmailDTO(
            email: email.email!,
            isValid: email.isValid,
            reason: email.reason!,
            isDisposable: email.isDisposable,
            role: email.role,
            isFree: email.isFree,
            safeToSend: email.safeToSend,
            domain: email.domain!,
            user: email.user!,
            isVerified: email.isVerified,
            isSpamList: email.isSpamList,
            isRetired: email.isRetired,
            isFabricated: email.isFabricated,
            breaches: (email.breaches?.sortedArray(using: []).map({return breachConverter.breachToBreachDTO($0 as! Breach)}))!,
            date: email.date!
        )
    }
    
    func emailDTOToEmail(_ email: EmailDTO) -> Email {
        return Email()
    }
}

