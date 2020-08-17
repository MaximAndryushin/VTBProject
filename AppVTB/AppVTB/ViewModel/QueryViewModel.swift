//
//  QueryViewModel.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 13.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

typealias BreachViewModel = BreachDTO

extension BreachViewModel {
    
    func description() -> String {
        var result = ""
        for (key, value) in Mirror(reflecting: self).children {
            if key != "info" {
                result.append("\(key!): \(value)\n")
            }
            else {
                result.append("\(key!): \((value as! String).htmlToString)\n")
            }
        }
        return result
    }
}

//MARK: - QueryModel

struct QueryViewModel: Codable, Equatable {
    
    // MARK: - Properties
    
    private var type: TypeOfQuery = .error
    private var name: String = ""
    private var date: Date = Date()
    private var parameters: [String : String] = [:]
    private var breaches: [BreachViewModel] = []
    
    // MARK: - Initializers
    
    init(_ type: TypeOfQuery, name: String, date: Date, parameters: [String : String], breaches: [BreachViewModel]) {
        self.type = type
        self.name = name
        self.date = date
        self.parameters = parameters
        self.breaches = breaches
    }
    
    init() { }
    
    
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
    
    func getBreaches() -> [BreachViewModel] {
        return breaches
    }
    
    var numberOfParameters: Int {
        return parameters.count
    }
}

extension QueryViewModel {
    func toLabels() -> [UILabel] {
        var labels = [UILabel]()
        labels.append(UILabel(text: getLabelText(), font: Constants.titleFont, alignment: .center))
        labels.append(UILabel(text: getDate(), font: Constants.titleFont, alignment: .center))
        labels.append(UILabel(text: getDescription(), font: Constants.systemFont))
        
        if !breaches.isEmpty {
            labels.append(UILabel(text: "Breaches:", font: Constants.titleFont, alignment: .center))
        }
        
        for breach in getBreaches() {
            labels.append(UILabel(text: breach.description(), font: Constants.systemFont))
        }
        return labels
    }
    
}
