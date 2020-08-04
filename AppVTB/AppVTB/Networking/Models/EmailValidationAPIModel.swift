//
//  EmailValidationAPIModel.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

struct EmailValidationAPIModel: Codable {
    let result, reason, disposable, acceptAll: String
    let role, free, email, user: String
    let domain, mxRecord, mxDomain, safeToSend: String
    let didYouMean, success, message: String
}
