//
//  ParserTests.swift
//  AppVTBTests
//
//  Created by Maxim Andryushin on 03.09.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import XCTest
@testable import AppVTB

class ParserTests: XCTestCase {
    
    private var parser: EmailNumberParser?

    override func setUpWithError() throws {
        try super.setUpWithError()
        parser = EmailNumberParser()
    }

    override func tearDownWithError() throws {
        parser = nil
        try super.tearDownWithError()
    }

    func testParserEmptyString() throws {
        //1. Assemble
        let emptyString = ""
        var type: TypeOfQuery?
        
        
        //2. Activate
        type = parser?.getType(from: emptyString)
        
        
        //3. Assert
        let unwrappedType = try XCTUnwrap(type)
        XCTAssertEqual(unwrappedType, .error)
    }
    
    func testParserNumber() throws {
        //1. Assemble
        let number = "+3128412947281"
        var type: TypeOfQuery?
        
        
        //2. Activate
        type = parser?.getType(from: number)
        
        
        //3. Assert
        let unwrappedType = try XCTUnwrap(type)
        XCTAssertEqual(unwrappedType, .number)
    }
    
    func testParserEmail() throws {
        //1. Assemble
        let email = "zhenek@mail.ru"
        var type: TypeOfQuery?
        
        
        //2. Activate
        type = parser?.getType(from: email)
        
        
        //3. Assert
        let unwrappedType = try XCTUnwrap(type)
        XCTAssertEqual(unwrappedType, .email)
    }
    
    func testParserWrongInput() throws {
        //1. Assemble
        let wrongInput = "2164tgudqgd1627.213d1"
        var type: TypeOfQuery?
        
        
        //2. Activate
        type = parser?.getType(from: wrongInput)
        
        
        //3. Assert
        let unwrappedType = try XCTUnwrap(type)
        XCTAssertEqual(unwrappedType, .error)
    }

}
