//
//  NetworkManagerTests.swift
//  AppVTBTests
//
//  Created by Maxim Andryushin on 02.09.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import XCTest
@testable import AppVTB

class NetworkManagerTests: XCTestCase {
    
    private var networkManager: NetworkWorker?

    override func setUpWithError() throws {
        try super.setUpWithError()
        networkManager = NetworkWorker(emailInfoManager: EmailValidationNetworkManager(), emailBreachManager: EmailPasswordNetworkManager(), numberManager: NumberNetworkManager(), emailNetworkConverter: EmailNetworkModelConverter(breachConverter: BreachNetworkModelConverter()), numberNetworkConverter: NumberNetworkModelConverter(), iconManager: ImageDownloadManager())
    }

    override func tearDownWithError() throws {
        networkManager = nil
        try super.tearDownWithError()
    }

    func testEmailValidationAPI() throws {
        //1. Assemble
        let mock = EmailValidationNetworkManager()
        let promise = self.expectation(description: "Request")
        var response: String?
        var responseError: String?
        
        
        //2. Activate
        
        mock.getInfo(about: "djcec123", completion: { data, error in
           
            responseError = error
            
            if let email = data {
                response = email.result
            }
            
            promise.fulfill()
            
        })
        
        
        //3. Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertEqual(response, "invalid")
    }

}
