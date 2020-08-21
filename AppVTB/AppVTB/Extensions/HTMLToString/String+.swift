//
//  String+.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 17.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

extension Data {
    var htmlToAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var htmlToString: String { htmlToAttributedString?.string ?? "" }
}

extension StringProtocol {
    var htmlToAttributedString: NSAttributedString? {
        Data(utf8).htmlToAttributedString
    }
    var htmlToString: String {
        htmlToAttributedString?.string ?? ""
    }
}
