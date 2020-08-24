//
//  UILabel+.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 17.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit


//usefull for this project
extension UILabel {
    convenience init(text: NSAttributedString, font: UIFont, alignment: NSTextAlignment = .natural) {
        self.init()
        self.attributedText = text
        self.textAlignment = alignment
        self.font = font
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
    }
}
