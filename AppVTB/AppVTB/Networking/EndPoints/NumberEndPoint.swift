//
//  NumberEndPoint.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

public enum NumberApi {
    case getNumberInfo(number: String)
    case doSmth
}

extension NumberApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "http://apilayer.net") else {
            fatalError("baseURL can't be configured")
        }
        return url
    }
    
    var path: String {
        return "/api/validate"
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getNumberInfo(let number):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "access_key": Key.numberAPI,
                                        "number": number])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
