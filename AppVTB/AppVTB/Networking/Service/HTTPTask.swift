//
//  HTTPTask.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        afterPathArguments: [String],
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionalHeaders: HTTPHeaders?)
}
