//
//  ConverterNetworkModelDTO.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 05.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit


// MARK: - NumberAPIResponse to DTO
protocol ConverterNumberNetworkModelToDTO {
    func convert(number: NumberAPIModel) -> NumberDTO
}

final class ConverterNumberNetworkModel: ConverterNumberNetworkModelToDTO {
    func convert(number: NumberAPIModel) -> NumberDTO {
        return NumberDTO(valid: number.valid,
                         number: number.number,
                         countryPrefix: number.countryPrefix,
                         countryCode: number.countryCode,
                         countryName: number.countryName,
                         location: number.location,
                         carrier: number.carrier,
                         lineType: number.lineType,
                         date: Date(timeIntervalSinceNow: 0)
        )
    }
}


// MARK: - BreachesAPIResponse to DTO
protocol ConverterBreachNetworkModelToDTO {
    func convert(breach: BreachAPI) -> BreachDTO
}

final class ConverterBreachNetworkModel: ConverterBreachNetworkModelToDTO {
    func convert(breach: BreachAPI) -> BreachDTO {
        return BreachDTO(name: breach.name,
                         domain: breach.domain,
                         addedDate: breach.addedDate,
                         modifiedDate: breach.modifiedDate,
                         info: breach.breachDescription,
                         logoPath: breach.logoPath
        )
    }
}

// MARK: - EmailAPIResponse to DTO
protocol ConverterEmailNetworkModelToDTO {
    func convert(email: EmailValidationAPIModel, breaches: EmailPasswordsAPIResponse) -> EmailDTO
}

final class ConverterEmailNetworkModel: ConverterEmailNetworkModelToDTO {
    
    private let breachConverter: ConverterBreachNetworkModelToDTO
    
    init(breachConverter: ConverterBreachNetworkModelToDTO) {
        self.breachConverter = breachConverter
    }
    
    func convert(email: EmailValidationAPIModel, breaches: EmailPasswordsAPIResponse) -> EmailDTO {
        var verified = true
        var spamList = false
        var retired = false
        var fabricated = false
        for breach in breaches {
            verified = verified && breach.isVerified
            spamList = spamList || breach.isSpamList
            retired = retired || breach.isRetired
            fabricated = fabricated || breach.isFabricated
        }
        return EmailDTO(email: email.email,
                        isValid: email.result == "valid",
                        reason: email.reason,
                        isDisposable: email.disposable == "true",
                        role: email.role == "true",
                        isFree: email.free == "true",
                        safeToSend: email.safeToSend == "true",
                        domain: email.domain,
                        user: email.user,
                        isVerified: verified,
                        isSpamList: spamList,
                        isRetired: retired,
                        isFabricated: fabricated,
                        breaches: breaches.map{ return breachConverter.convert(breach: $0) },
                        date: Date(timeIntervalSinceNow: 0)
        )
    }
}
