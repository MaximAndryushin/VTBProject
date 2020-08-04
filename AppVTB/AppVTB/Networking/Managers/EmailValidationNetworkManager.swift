//
//  EmailValidationNetworkManager.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

struct EmailValidationNetworkManager: NetworkResponseHandler {
        
    let router = Router<EmailValidationAPI>()
    
    func getInfo(about email: String, completion: @escaping (_ email: EmailValidationAPIModel?, _ error: String?) -> ()) {
        router.request(.getEmailInfo(email: email), modelType: EmailValidationAPIModel.self) { data, error in
            completion(data, error)
        }
    }
}

