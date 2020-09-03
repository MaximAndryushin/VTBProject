//
//  NetworkResponseToDTOConverterTests.swift
//  AppVTBTests
//
//  Created by Maxim Andryushin on 03.09.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import XCTest
@testable import AppVTB

class NumberNetworkResponseToDTOConverterTests: XCTestCase {
    
    private var converter: NumberNetworkModelConverter?

    override func setUpWithError() throws {
        try super.setUpWithError()
        converter = NumberNetworkModelConverter()
    }

    override func tearDownWithError() throws {
        converter = nil
        try super.tearDownWithError()
    }

    func testConvert() throws {
        //1. Assemble
        let APIResponse = NumberAPIModel(valid: true, number: "248124102482194", countryPrefix: "ewfe", countryCode: "EFWEF", countryName: "erer23r23e", location: "er23rj23ri23", carrier: "rbgjefeof", lineType: "edf")
        var numberDTO: NumberDTO?
        
        
        //2. Activate
        numberDTO = converter?.convert(number: APIResponse)
        
        
        //3. Assert
        let number = try XCTUnwrap(numberDTO)
        XCTAssertEqual(number.valid, APIResponse.valid)
        XCTAssertEqual(number.countryCode, APIResponse.countryCode)
        XCTAssertEqual(number.location, APIResponse.location)
        XCTAssert(number.date.distance(to: Date()) < 0.1)
        //...
    }
    
}
