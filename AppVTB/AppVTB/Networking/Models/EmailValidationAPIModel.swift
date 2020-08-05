//
//  EmailValidationAPIModel.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

struct EmailValidationAPIModel: Codable {
    let result: String
    let reason: String
    let disposable: String
    let acceptAll: String
    let role: String
    let free: String
    let email: String
    let user: String
    let domain: String
    let mxRecord: String
    let mxDomain: String
    let safeToSend: String
    let didYouMean: String
    let success: String
    let message: String
}
