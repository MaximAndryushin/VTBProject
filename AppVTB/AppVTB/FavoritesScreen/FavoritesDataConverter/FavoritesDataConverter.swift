//
//  DataConverter.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 10.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol FavoritesDataConverterInput {
    func createViewModelFrom(number: NumberDTO) -> Query
    func createViewModelFrom(email: EmailDTO) -> Query
}

final class FavoritesDataConverter {
    private let numberConverter: NumberDTOQueryConverter
    private let emailConverter: EmailDTOQueryConverter
    
    init(numberConverter: NumberDTOQueryConverter, emailConverter: EmailDTOQueryConverter) {
        self.numberConverter = numberConverter
        self.emailConverter = emailConverter
    }
}


extension FavoritesDataConverter: FavoritesDataConverterInput {
    
    func createViewModelFrom(number: NumberDTO) -> Query {
        return numberConverter.convertToQuery(from: number)
    }
    
    func createViewModelFrom(email: EmailDTO) -> Query {
        return emailConverter.convertToQuery(from: email)
    }
    
    
}
