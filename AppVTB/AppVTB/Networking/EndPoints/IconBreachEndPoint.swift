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
        switch self {
        case .getIcon(let name) :
            return URL(string: name)!
        case .doSmth:
            return URL(string: "https://ru.wikipedia.org/wiki/%D0%9E%D1%88%D0%B8%D0%B1%D0%BA%D0%B0_404")!
        }
    }
    
    var path: String {
       return String()
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
