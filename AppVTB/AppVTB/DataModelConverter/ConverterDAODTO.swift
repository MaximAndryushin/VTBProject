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
protocol NumberDTODAOConverter {
    func phoneNumberToNumberDTO(_ number: PhoneNumber) -> NumberDTO
    func numberDTOToPhoneNumber(_ number: NumberDTO) -> PhoneNumber
    func update(_ number: inout PhoneNumber?, numberDTO: NumberDTO)
}

final class NumberConverter: NumberDTODAOConverter {
    
    func update(_ number: inout PhoneNumber?, numberDTO: NumberDTO) {
        if number == nil {
            number = PhoneNumber()
        }
        number!.carrier = numberDTO.carrier
        number!.countryCode = numberDTO.countryCode
        number!.countryName = numberDTO.countryName
        number!.countryPrefix = numberDTO.countryPrefix
        number!.date = numberDTO.date
        number!.lineType = numberDTO.lineType
        number!.location = numberDTO.location
        number!.number = numberDTO.number
        number!.valid = numberDTO.valid
    }
    
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
        var numberModel: PhoneNumber?
        update(&numberModel, numberDTO: number)
        return numberModel!
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

protocol BreachDTODAOConverter {
    func breachToBreachDTO(_ breach: Breach) -> BreachDTO
    func breachDTOToBreach(_ breach: BreachDTO) -> Breach
}

final class BreachConverter: BreachDTODAOConverter {
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
        let breachModel = Breach()
        breachModel.addedDate = breach.addedDate
        breachModel.domain = breach.domain
        breachModel.info = breach.info
        breachModel.logoPath = breach.logoPath
        breachModel.modifiedDate = breach.modifiedDate
        breachModel.name = breach.name
        return breachModel
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

protocol EmailDTODAOConverter {
    func emailToEmailDTO(_ email: Email) -> EmailDTO
    func emailDTOToEmail(_ email: EmailDTO) -> Email
    func update(_ emailModel: inout Email?, email: EmailDTO)
}

final class EmailConverter: EmailDTODAOConverter {
    
    //MARK: - Properties
    
    let breachConverter: BreachDTODAOConverter
    
    
    init(converter: BreachDTODAOConverter) {
        self.breachConverter = converter
    }
    
    
    //MARK: - Methods
    
    func update(_ emailModel: inout Email?, email: EmailDTO) {
        if emailModel == nil {
            emailModel = Email()
        }
        emailModel!.date = email.date
        emailModel!.user = email.user
        emailModel!.domain = email.domain
        emailModel!.role = email.role
        emailModel!.safeToSend = email.safeToSend
        emailModel!.email = email.email
        emailModel!.isDisposable = email.isDisposable
        emailModel!.isValid = email.isValid
        emailModel!.isFabricated = email.isFabricated
        emailModel!.isFree = email.isFree
        emailModel!.isRetired = email.isRetired
        emailModel!.isSpamList = email.isSpamList
        emailModel!.isVerified = email.isVerified
        emailModel!.isValid = email.isValid
        emailModel!.reason = email.reason
        emailModel!.breaches = NSSet(array: email.breaches.map{ return breachConverter.breachDTOToBreach($0) })
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
            breaches: (email.breaches?.sortedArray(using: []).map{ return breachConverter.breachToBreachDTO($0 as! Breach) })!,
            date: email.date!
        )
    }
    
    func emailDTOToEmail(_ email: EmailDTO) -> Email {
        var emailModel: Email?
        update(&emailModel, email: email)
        return emailModel!
    }
}

