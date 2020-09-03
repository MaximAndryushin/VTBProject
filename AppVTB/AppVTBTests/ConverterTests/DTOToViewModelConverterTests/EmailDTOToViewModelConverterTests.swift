//
//  EmailDTOToViewModelConverterTests.swift
//  AppVTBTests
//
//  Created by Maxim Andryushin on 03.09.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import XCTest
@testable import AppVTB

class EmailDTOToViewModelConverterTests: XCTestCase {
    
    private var converter: EmailToQueryConverter?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        converter = EmailToQueryConverter()
    }
    
    override func tearDownWithError() throws {
        converter = nil
        try super.tearDownWithError()
    }
    
    func testConvert() throws {
        //1. Assemble
        let emailDTO = EmailDTO(email: "wfomwf@kfwef", isValid: true, reason: "wjfownf", isDisposable: false, role: false, isFree: true, safeToSend: true, domain: "kfwef", user: "wfomwf", isVerified: true, isSpamList: false, isRetired: false, isFabricated: false, breaches: [], date: Date())
        var viewModel: QueryViewModel?
        
        
        //2. Activate
        viewModel = converter?.convertToQuery(from: emailDTO)
        
        
        //3. Assert
        let model = try XCTUnwrap(viewModel)
        XCTAssertEqual(model.date, emailDTO.date)
        XCTAssertEqual(model.type, .email)
        XCTAssertEqual(model.name, emailDTO.email)
        //...
    }
}
