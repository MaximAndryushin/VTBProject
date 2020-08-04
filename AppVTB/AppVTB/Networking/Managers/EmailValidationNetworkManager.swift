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
    
    func getInfo(about email: String, completion: @escaping (_ email: EmailValidationAPIModel?, _ error: String?)->()) {
        router.request(.getEmailInfo(email: email)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase //IMPORTANT
                        let response = try decoder.decode(EmailValidationAPIModel.self, from: responseData)
                        completion(response, nil)
                    } catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}

