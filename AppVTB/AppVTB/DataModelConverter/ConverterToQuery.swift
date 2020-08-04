//
//  ConverterToQuery.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 01.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import Foundation

protocol QueryConverter {
    associatedtype DTO
    
    static func convertToQuery(from object: DTO, date: Date) -> Query
}


// MARK: - Phone To Query
struct PhoneToQueryConverter: QueryConverter {
    static func convertToQuery(from object: NumberAPIModel, date: Date) -> Query {
        let numberMirror = Mirror(reflecting: object)
        let parameters = Dictionary(uniqueKeysWithValues: numberMirror.children.map({
            return ($0.label!, "\($0.value)")
        }).filter({ $0.0 != "number"}))
        return Query(.number, name: object.number, date: date, parameters: parameters)
    }
}


// MARK: - Email To Query
struct EmailToQueryConverter: QueryConverter {
    static func convertToQuery(from object: EmailDTO, date: Date) -> Query {
        let emailMirror = Mirror(reflecting: object)
        let parameters = Dictionary<String, String>(uniqueKeysWithValues: emailMirror.children.map({
            if $0.label! == "breaches", let breaches = $0.value as? [BreachDTO] {
                return ("breaches", "\(breaches.count)")
            } else {
                return ($0.label!, "\($0.value)")
            }
        }).filter({ $0.0 != "email"}))
        return Query(.email, name: object.email, date: date, parameters: parameters)
    }
}


