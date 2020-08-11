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
            let queries: [Query]
        }
        
        struct viewModel {
            let queries: [Query]
        }
        
    }
    
}


//MARK: - QueryModel(model HistoryTableViewCell)

struct Query: Codable, Equatable {
    
    // MARK: - Properties
    
    private var type: TypeOfQuery = .error
    private var name: String = ""
    private var date: Date = Date()
    private var parameters: [String : String] = [:]
    
    // MARK: - Initializers
    
    init(_ type: TypeOfQuery, name: String, date: Date, parameters: [String : String]) {
        self.type = type
        self.name = name
        self.date = date
        self.parameters = parameters
    }
    
    
    //MARK: - Gettes for CellModel
    
    func getLabelText() -> String {
        return "\(type.rawValue) : \(name)"
    }
    
    func getName() -> String {
        return name
    }
    
    func getType() -> TypeOfQuery {
        return type
    }
    
    func getRawDate() -> Date {
        return date
    }
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm:ss" // TO THINK how it looks
        return formatter.string(from: date)
    }
    
    func getDescription() -> String {
        var result = ""
        for (key, value) in parameters.sorted(by: <) {
            result.append(contentsOf: "\(key) : \(value) \n")
        }
        return result
    }
    
    mutating func filterDesription(filter: (_ key: String) -> Bool) {
        parameters = parameters.filter { return filter($0.key) }
    }
    
    var numberOfParameters: Int {
        return parameters.count
    }
}
