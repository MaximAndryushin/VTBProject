//
//  EmailPasswordNetworkManager.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

final class EmailCheckNetworkManager: NetworkResponseHandler {
        
    let router = Router<EmailPasswordAPI>()
    
    func getInfo(about email: String, completion: @escaping (_ email: EmailPasswordsAPIResponse?, _ error: String?)->()) {
        router.request(.getBreachesWith(email: email)) { data, response, error in
            
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
                        let response = try decoder.decode(EmailPasswordsAPIResponse.self, from: responseData)
                        completion(response, nil)
                    } catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    if networkFailureError == "Not found" {
                        completion([], nil)
                    }
                    else {
                        completion(nil, networkFailureError)
                    }
                }
            }
        }
    }
}
