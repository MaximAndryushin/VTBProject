//
//  HistoryWorker.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 16.07.2020.
//  Copyright (c) 2020 Maxim Andryushin. All rights reserved.


import UIKit

//TEMPORARY STUB

final class HistoryWorker {
    
    func getQueries(with type: TypeOfQuery?, isAscending: Bool) -> [Query] {
        return [
            Query(.email, name: "email@example.com", date: Date(timeIntervalSinceNow: TimeInterval(exactly: 5.8)!), parameters: ["isValid" : "true", "isFuckedUp" : "true"]),
            Query(.number, name: "+79102382390", date: Date(timeIntervalSinceNow: TimeInterval(exactly: 7.9)!), parameters: ["isValid" : "true", "country" : "Russia"]),
            Query(.email, name: "HMMM@example.com", date: Date(timeIntervalSinceNow: TimeInterval(exactly: 10.4)!), parameters: ["isValid" : "true", "number of passwords" : "13", "some useless info" : "vsemprivet", "hochu" : "pitsu"]),
            ].filter { (query) -> Bool in
                if let type = type {
                    return query.getType() == type
                }
                return true
        }.sorted { (first, second) -> Bool in
            return (isAscending != (first.getDate() > second.getDate()))
        }
    }
}
