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


//MARK: - Parser

struct EmailNumberParser {
    
    static func getType(from text: String) -> TypeOfQuery {
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
    
    private static func isEmail(_ text: String) -> Bool { // check that addres contain only 1 '@' and local and domain parts aren't empty
        if text.isEmpty {
            return false
        }
        let index = text.firstIndex(of: "@")
        if index == text.endIndex || index != text.lastIndex(of: "@") {
            return false
        }
        return index != text.startIndex && text.index(after: index!) != text.endIndex
    }
    
    
    private static func isNumber(_ text: String) -> Bool { //check that phone number consist of digits
        if text.isEmpty {
            return false
        }
        var index = text.startIndex
        if text[index] == "+" {
            index = text.index(after: index)
        }
        while index != text.endIndex {
            if !text[index].isNumber || !text[index].isASCII {
                return false
            }
        }
        return true
    }
}
