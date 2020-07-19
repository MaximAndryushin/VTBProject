//
//  HistoryModels.swift
//  VTBAPP
//
//  Created by Maxim Andryushin on 16.07.2020.
//  Copyright (c) 2020 Maxim Andryushin. All rights reserved.

import UIKit

enum History {
    // MARK: - Use cases
    
    enum ShowQueries {
        struct Request {
            let type: TypeOfQuery?
            let isAscending: Bool
        }
        
        struct Response {
            let queries: [Query] // there will be DTO after i make normal models and CoreData stuff
        }
        
        struct viewModel {
            let queries: [Query]
        }
        
    }
    
    enum Save { // I'll think about deletion of record by swipe
        struct Request {
        }
        
        struct Response {
        }
        
        struct ViewModel {
        }
        
    }
}


//MARK: - QueryModel(model HistoryTableViewCell)

struct Query: Codable {
    
    // MARK: - Properties
    
    private var type: TypeOfQuery
    private var name: String
    private var date: Date
    private var parameters: [String : String]
    
    // MARK: - Initializers
    
    init(_ type: TypeOfQuery, name: String, date: Date, parameters: [String : String]) {
        self.type = type
        self.name = name
        self.date = date
        self.parameters = parameters
    }
    
    //MARK: - Gettes for CellModel
    
    func getLabelText() -> String {
        return type.rawValue + ": " + name
    }
    
    func getType() -> TypeOfQuery {
        return type
    }
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm:ss" // don't forget to change this
        return formatter.string(from: date)
    }
    
    func getDescription() -> String {
        var result = ""
        //have problem with this(maybe it connected with concurrency (parameters can be in different order))
        for (param, value) in parameters {
            result.append(contentsOf: param + ": " + value + "\n")
        }
        return result
    }
    
    var numberOfParameters: Int {
        return parameters.count
    }
}
