//
//  UILabel+.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 17.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit


//MARK: - Fabric Method

extension UILabel {
    convenience init(text: String, font: UIFont, alignment: NSTextAlignment = .natural) {
        self.init()
        self.text = text
        self.textAlignment = alignment
        self.font = font
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
    }
}
