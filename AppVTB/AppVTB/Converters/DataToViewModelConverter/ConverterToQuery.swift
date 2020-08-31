//
//  ConverterToQuery.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 01.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import Foundation

// MARK: - Phone To Query

protocol NumberDTOToViewModelConverterInput {
    func convertToQuery(from object: NumberDTO) -> QueryViewModel
}

final class NumberToQueryConverter: NumberDTOToViewModelConverterInput {
    func convertToQuery(from object: NumberDTO) -> QueryViewModel {
        let numberMirror = Mirror(reflecting: object)
        let parameters = Dictionary(uniqueKeysWithValues: numberMirror.children.map({
            return ($0.label ?? "unnamedParameter", "\($0.value)")
        }).filter({ $0.0 != "number" && $0.0 != "date" }))
        return QueryViewModel(.number, name: object.number, date: object.date, parameters: parameters, breaches: [])
    }
}


// MARK: - Email To ViewModel

protocol EmailDTOToViewModelConverterInput {
    func convertToQuery(from object: EmailDTO) -> QueryViewModel
}

final class EmailToQueryConverter: EmailDTOToViewModelConverterInput {
    func convertToQuery(from object: EmailDTO) -> QueryViewModel {
        let emailMirror = Mirror(reflecting: object)
        let parameters = Dictionary<String, String>(uniqueKeysWithValues: emailMirror.children.map({
            if $0.label ?? "unnamedParameter" == "breaches", let breaches = $0.value as? [BreachDTO] {
                return ("breaches", "\(breaches.count)")
            } else {
                return ($0.label ?? "unnamedParameter", "\($0.value)")
            }
        }).filter({ $0.0 != "email" && $0.0 != "date" }))
        return QueryViewModel(.email, name: object.email, date: object.date, parameters: parameters, breaches: object.breaches)
    }
}


