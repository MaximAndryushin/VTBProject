//
//  EmailNetworkResponseToDTOConverterTests.swift
//  AppVTBTests
//
//  Created by Maxim Andryushin on 03.09.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import XCTest
@testable import AppVTB

class EmailNetworkResponseToDTOConverterTests: XCTestCase {
    
    private var converter: EmailNetworkModelConverter?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        converter = EmailNetworkModelConverter(breachConverter: BreachNetworkModelConverter())
    }
    
    override func tearDownWithError() throws {
        converter = nil
        try super.tearDownWithError()
    }
    
    func testConvert() throws {
        //1. Assemble
        let validationAPIResponse = EmailValidationAPIModel(result: "wdwd", reason: "good", disposable: "false", acceptAll: "true", role: "a", free: "b", email: "c", user: "d", domain: "e", mxRecord: "f", mxDomain: "g", safeToSend: "h", didYouMean: "i", success: "j", message: "k")
        let breachAPIResponse = EmailAPIResponse(repeating: (BreachAPI(name: "l", title: "m", domain: "n", breachDate: "o", addedDate: "p", modifiedDate: "q", pwnCount: 12, breachDescription: "r", logoPath: "s", dataClasses: [], isVerified: true, isFabricated: true, isSensitive: false, isRetired: false, isSpamList: false), nil), count: 10)
        var emailDTO: EmailDTO?
        
        
        //2. Activate
        emailDTO = converter?.convert(email: validationAPIResponse, breaches: breachAPIResponse)
        
        
        //3. Assert
        let email = try XCTUnwrap(emailDTO)
        XCTAssertEqual(email.reason, validationAPIResponse.reason)
        XCTAssertEqual(email.domain, validationAPIResponse.domain)
        XCTAssertEqual(email.breaches.first?.addedDate, breachAPIResponse.first?.0.addedDate)
        XCTAssert(email.date.distance(to: Date()) < 0.1)
        //...
    }
    
}
