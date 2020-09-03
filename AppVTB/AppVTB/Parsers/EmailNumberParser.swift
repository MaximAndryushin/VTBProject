//
//  EmailNumberParder.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 19.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit


//MARK: - TypeOfQuery

enum TypeOfQuery: String, Codable {
    case email = "Email"
    case number = "Phone Number"
    case error = "ERROR"
}

protocol ParserInput {
    func getType(from text: String) -> TypeOfQuery
}

//MARK: - Parser

final class EmailNumberParser: ParserInput {
    
    func getType(from text: String) -> TypeOfQuery {
        if isEmail(text) {
            return .email
        }
        else if isNumber(text) {
            return .number
        }
        else {
            return .error
        }
    }
    
    private func isEmail(_ text: String) -> Bool {
        if text.isEmpty {
            return false
        }
        let emailRegEx = ".+@{1}.+\\..+" // Check only @ and . (because API do validation work, all I need from parser is to distinguish email from number
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: text)
    }
    
    
    private func isNumber(_ text: String) -> Bool {
        if text.isEmpty {
            return false
        }
        let numberRegEx = "(\\+?)([0-9]+)" // Check that number consisist only from digits
        let numberPred = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return numberPred.evaluate(with: text)
    }
}
