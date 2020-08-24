//
//  NumberNetworkManager.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

protocol PhoneNumberNetworkManagerInput {
    func getInfo(about number: String, completion: @escaping (_ number: NumberAPIModel?, _ error: String?) -> ())
}

final class NumberNetworkManager: NetworkResponseHandler, PhoneNumberNetworkManagerInput {
    
    let router = Router<NumberApi>()
    
    func getInfo(about number: String, completion: @escaping (_ number: NumberAPIModel?, _ error: String?) -> ()) {
        router.request(.getNumberInfo(number: number), modelType: NumberAPIModel.self) { data, error in
            completion(data, error)
        }
    }
}
