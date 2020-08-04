//
//  NetworkManager.swift
//  AppVTB
//
//  Created by Maxim Andryushin on 31.07.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import Foundation

public enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case notFound = "Not found"
}

public enum Result<String> {
    case success
    case failure(String)
}

protocol NetworkResponseHandler {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>
}

extension NetworkResponseHandler {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 404: return .failure(NetworkResponse.notFound.rawValue)
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
