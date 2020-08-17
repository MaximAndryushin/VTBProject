//
//  ConverterToQuery.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 01.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import Foundation

// MARK: - Phone To Query

protocol NumberDTOQueryConverter {
    func convertToQuery(from object: NumberDTO) -> QueryViewModel
}

final class NumberToQueryConverter: NumberDTOQueryConverter {
    func convertToQuery(from object: NumberDTO) -> QueryViewModel {
        let numberMirror = Mirror(reflecting: object)
        let parameters = Dictionary(uniqueKeysWithValues: numberMirror.children.map({
            return ($0.label!, "\($0.value)")
        }).filter({ $0.0 != "number" && $0.0 != "date" }))
        return QueryViewModel(.number, name: object.number, date: object.date, parameters: parameters, breaches: [])
    }
}


// MARK: - Email To Query

protocol EmailDTOQueryConverter {
    func convertToQuery(from object: EmailDTO) -> QueryViewModel
}

final class EmailToQueryConverter: EmailDTOQueryConverter {
    func convertToQuery(from object: EmailDTO) -> QueryViewModel {
        let emailMirror = Mirror(reflecting: object)
        let parameters = Dictionary<String, String>(uniqueKeysWithValues: emailMirror.children.map({
            if $0.label! == "breaches", let breaches = $0.value as? [BreachDTO] {
                return ("breaches", "\(breaches.count)")
            } else {
                return ($0.label!, "\($0.value)")
            }
        }).filter({ $0.0 != "email" && $0.0 != "date" }))
        return QueryViewModel(.email, name: object.email, date: object.date, parameters: parameters, breaches: object.breaches)
    }
}


