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
    
    private enum Keys: String {
        case info = "info"
        case logo = "logo"
        case other
    }
    
    var description: NSAttributedString {
        let result = NSMutableAttributedString()
        for (key, value) in Mirror(reflecting: self).children {
            if let key = key {
                switch key {
                case Keys.info.rawValue:
                    result.append(NSAttributedString(string: "\(key): \((value as! String).htmlToString)\n"))
                case Keys.logo.rawValue:
                    if let value = value as? Data, let image = UIImage(data: value) {
                        let logo = NSTextAttachment()
                        logo.image = image
                        logo.bounds = CGRect(x: 0, y: 0, width: min(image.size.width * image.size.height / Constants.logoHeight, Constants.logoWidth), height: Constants.logoHeight)
                        result.append(NSAttributedString(string: "\(key): "))
                        result.append(NSAttributedString(attachment: logo))
                        result.append(NSAttributedString(string: "\n"))
                    }
                default:
                    result.append(NSAttributedString(string: "\(key): \(value)\n"))
                }
            }
        }
        return result
    }
    
    var icon: UIImage? {
        if let icon = self.logo {
            return UIImage(data: icon)
        } else {
            return nil
        }
    }
}

//MARK: - QueryModel

struct QueryViewModel: Codable, Equatable {
    
    // MARK: - Properties
    
    private var _type: TypeOfQuery = .error
    private var _name: String = ""
    private var _date: Date = Date()
    private var _parameters: [String : String] = [:]
    private var _breaches: [BreachViewModel] = []
    
    // MARK: - Initializers
    
    init(_ type: TypeOfQuery, name: String, date: Date, parameters: [String : String], breaches: [BreachViewModel]) {
        _type = type
        _name = name
        _date = date
        _parameters = parameters
        _breaches = breaches
    }
    
    init() { }
    
    
    //MARK: - Getters for CellModel
    
    var labelText: String {
        return "\(type.rawValue) : \(name)"
    }
    
    var name: String {
        return _name
    }
    
    var type: TypeOfQuery {
        return _type
    }
    
    var date: Date {
        return _date
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm:ss" 
        return formatter.string(from: date)
    }
    
    var descriptionOfProperties: String {
        var result = ""
        for (key, value) in _parameters.sorted(by: <) {
            result.append(contentsOf: "\(key) : \(value) \n")
        }
        return result
    }
    
    mutating func filterDesription(filter: (_ key: String) -> Bool) {
        _parameters = _parameters.filter { return filter($0.key) }
    }
    
    var breaches: [BreachViewModel] {
        return _breaches
    }
    
    var numberOfParameters: Int {
        return _parameters.count
    }
}

protocol PropertiesToLabelsProtocol {
    var labels: [UILabel] { get }
}

extension QueryViewModel: PropertiesToLabelsProtocol{
    var labels: [UILabel] {
        var labels = [UILabel]()
        labels.append(UILabel(text: NSAttributedString(string: labelText), font: Constants.titleFont, alignment: .center))
        labels.append(UILabel(text: NSAttributedString(string: formattedDate), font: Constants.titleFont, alignment: .center))
        labels.append(UILabel(text: NSAttributedString(string: descriptionOfProperties), font: Constants.systemFont))
        
        if !breaches.isEmpty {
            labels.append(UILabel(text: NSAttributedString(string: "Breaches:"), font: Constants.titleFont, alignment: .center))
        }
        
        for breach in breaches {
            let label = UILabel(text: breach.description, font: Constants.systemFont)
            labels.append(label)
        }
        
        return labels
    }
    
}
