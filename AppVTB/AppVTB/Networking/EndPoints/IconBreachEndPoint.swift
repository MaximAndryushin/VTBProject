//
//  IconBreachEndPoint.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 17.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import UIKit

public enum ImageDownload {
    case getIcon(name: String)
    case doSmth
}

extension ImageDownload: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://haveibeenpwned.com") else {
            fatalError("baseURL can't be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getIcon(let name):
            return "/Content/Images/PwnedLogos/\(name)"
        case .doSmth:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
