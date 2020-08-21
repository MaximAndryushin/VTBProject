//
//  DataConverter.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 10.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol DataConverterInput {
    func createViewModelFrom(number: NumberDTO) -> QueryViewModel
    func createViewModelFrom(email: EmailDTO) -> QueryViewModel
}

final class DataToViewModelConverter {
    private let numberConverter: NumberDTOQueryConverter
    private let emailConverter: EmailDTOQueryConverter
    
    init(numberConverter: NumberDTOQueryConverter, emailConverter: EmailDTOQueryConverter) {
        self.numberConverter = numberConverter
        self.emailConverter = emailConverter
    }
}


extension DataToViewModelConverter: DataConverterInput {
    
    func createViewModelFrom(number: NumberDTO) -> QueryViewModel {
        return numberConverter.convertToQuery(from: number)
    }
    
    func createViewModelFrom(email: EmailDTO) -> QueryViewModel {
        return emailConverter.convertToQuery(from: email)
    }
    
    
}
