//
//  EmailPasswordNetworkManager.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol EmailBreachNetworkManagerInput {
    func getInfo(about email: String, completion: @escaping (_ email: EmailPasswordsAPIResponse?, _ error: String?) -> ())
}

final class EmailPasswordNetworkManager: NetworkResponseHandler, EmailBreachNetworkManagerInput {
        
    let router = Router<EmailPasswordAPI>()
    
    func getInfo(about email: String, completion: @escaping (_ email: EmailPasswordsAPIResponse?, _ error: String?) -> ()) {
        router.request(.getBreachesWith(email: email), modelType: [BreachAPI].self) { data, error in
            if let error = error, error == NetworkResponse.notFound.rawValue {
                completion([], nil)
            } else {
                completion(data, error)
            }
        }
    }
}
