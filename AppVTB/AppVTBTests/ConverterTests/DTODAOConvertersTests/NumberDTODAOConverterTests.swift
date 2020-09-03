//
//  NumberDTODAOConverterTests.swift
//  AppVTBTests
//
//  Created by Maxim Andryushin on 03.09.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import XCTest
@testable import AppVTB

class NumberDTODAOConverterTests: XCTestCase {
    
    private var converter: NumberConverter?

    override func setUpWithError() throws {
        try super.setUpWithError()
        converter = NumberConverter()
    }

    override func tearDownWithError() throws {
        converter = nil
        try super.tearDownWithError()
    }

    func testDTOtoDAO() throws {
        //1. Assemble
        let numberDTO = NumberDTO(valid: true, number: "+79102382390", countryPrefix: "+7", countryCode: "RU", countryName: "Russia", location: "Russian Federation", carrier: "MTS", lineType: "mobile", date: Date())
        var numberDAO: PhoneNumber?
        
        
        //2. Activate
        numberDAO = converter?.numberDTOToPhoneNumber(numberDTO)
        
        
        //3. Assert
        let number = try XCTUnwrap(numberDAO)
        XCTAssertEqual(number.date, numberDTO.date)
        XCTAssertEqual(number.number, numberDTO.number)
        XCTAssertEqual(number.valid, numberDTO.valid)
        //...
    }
    
    func testDAOtoDTO() throws {
        //1. Assemble
        let numberDAO = PhoneNumber()
        numberDAO.carrier = "mts"
        numberDAO.countryCode = "mdamda"
        numberDAO.lineType = "pescherniy telephon"
        var numberDTO: NumberDTO?
        
        
        //2. Activate
        numberDTO = converter?.phoneNumberToNumberDTO(numberDAO)
        
        
        //3. Assert
        let number = try XCTUnwrap(numberDTO)
        XCTAssertEqual(number.carrier, numberDAO.carrier)
        XCTAssertEqual(number.countryCode, numberDAO.countryCode)
        XCTAssertEqual(number.lineType, numberDAO.lineType)
        //...
    }
    
    
}
