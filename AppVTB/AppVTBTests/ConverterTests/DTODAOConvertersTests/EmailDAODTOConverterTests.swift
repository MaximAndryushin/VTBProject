//
//  EmailDAODTOParserTests.swift
//  AppVTBTests
//
//  Created by Maxim Andryushin on 03.09.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import XCTest
@testable import AppVTB

class EmailDAODTOConverterTests: XCTestCase {
    
    private var converter: EmailConverter?

    override func setUpWithError() throws {
        try super.setUpWithError()
        converter = EmailConverter(converter: BreachConverter())
    }

    override func tearDownWithError() throws {
        converter = nil
        try super.tearDownWithError()
    }

    func testDTOtoDAO() throws {
        //1. Assemble
        let emailDTO = EmailDTO(email: "wfomwf@kfwef", isValid: true, reason: "wjfownf", isDisposable: false, role: false, isFree: true, safeToSend: true, domain: "kfwef", user: "wfomwf", isVerified: true, isSpamList: false, isRetired: false, isFabricated: false, breaches: [], date: Date())
        var emailDAO: Email?
        
        
        //2. Activate
        emailDAO = converter?.emailDTOToEmail(emailDTO)
        
        
        //3. Assert
        let email = try XCTUnwrap(emailDAO)
        XCTAssertEqual(emailDTO.date, email.date)
        XCTAssertEqual(emailDTO.email, email.email)
        XCTAssertEqual(emailDTO.isValid, email.isValid)
        //...
    }
    
    func testDAOtoDTO() throws {
        //1. Assemble
        let emailDAO = Email()
        emailDAO.date = Date()
        emailDAO.email = "efjwefoew"
        emailDAO.isValid = true
        var emailDTO: EmailDTO?
        
        
        //2. Activate
        emailDTO = converter?.emailToEmailDTO(emailDAO)
        
        
        //3. Assert
        let email = try XCTUnwrap(emailDTO)
        XCTAssertEqual(emailDAO.date, email.date)
        XCTAssertEqual(emailDAO.email, email.email)
        XCTAssertEqual(emailDAO.isValid, email.isValid)
        //...
    }

}
