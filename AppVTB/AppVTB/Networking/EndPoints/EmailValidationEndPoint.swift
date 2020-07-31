//
//  EmailValidationEndPoint.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

public enum EmailValidationAPI {
    case getEmailInfo(email: String)
    case doSmth
}

extension EmailValidationAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "http://api.quickemailverification.com") else {
            fatalError("baseURL can't be configured")
        }
        return url
    }
    
    var path: String {
        return "/v1/verify"
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getEmailInfo(let email):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "email": email,
                                        "apikey": Key.emailValidationAPI,
                                        ])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
