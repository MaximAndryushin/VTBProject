//
//  EmailPasswordEndPoint.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

public enum EmailPasswordAPI {
    case getBreachesWith(email: String)
    case doSmth
}

extension EmailPasswordAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://haveibeenpwned.com") else {
            fatalError("baseURL can't be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getBreachesWith(let email):
            return "/api/v3/breachedaccount/" + email
        case .doSmth:
            return "/api/v3/breachedaccount/"
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getBreachesWith( _):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                bodyEncoding: .urlEncoding,
                                                urlParameters: ["truncateResponse": "false"],
                                                additionalHeaders: headers)
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return ["hibp-api-key" : Key.emailPasswordAPI]
    }
    
    
}
