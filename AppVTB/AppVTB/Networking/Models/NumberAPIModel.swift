//
//  NumberAPIModel.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

class NumberAPIModel: Decodable {
    let valid: Bool
    let number: String
    let localFormat: String
    let internationalFormat: String
    let countryPrefix: String
    let countryCode: String
    let countryName: String
    let location: String
    let carrier: String
    let lineType: String
}
