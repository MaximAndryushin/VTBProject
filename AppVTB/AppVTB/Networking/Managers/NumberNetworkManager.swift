//
//  NumberNetworkManager.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

struct NumberNetworkManager: NetworkResponseHandler {
    
    
    let router = Router<NumberApi>()
    
    func getInfo(about number: String, completion: @escaping (_ number: NumberAPIModel?, _ error: String?)->()) {
        router.request(.getNumberInfo(number: number)) { data, response, error in
            
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
                        let response = try decoder.decode(NumberAPIModel.self, from: responseData)
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
