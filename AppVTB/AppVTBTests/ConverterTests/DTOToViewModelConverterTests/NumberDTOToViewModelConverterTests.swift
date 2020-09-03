//
//  NumberDTOToViewModelConverterTests.swift
//  AppVTBTests
//
//  Created by Maxim Andryushin on 03.09.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import XCTest
@testable import AppVTB

class NumberDTOToViewModelConverterTests: XCTestCase {

    private var converter: NumberToQueryConverter?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        converter = NumberToQueryConverter()
    }
    
    override func tearDownWithError() throws {
        converter = nil
        try super.tearDownWithError()
    }
    
    func testConvert() throws {
        //1. Assemble
        let numberDTO = NumberDTO(valid: true, number: "+79102382390", countryPrefix: "+7", countryCode: "RU", countryName: "Russia", location: "Russian Federation", carrier: "MTS", lineType: "mobile", date: Date())
        var viewModel: QueryViewModel?
        
        
        //2. Activate
        viewModel = converter?.convertToQuery(from: numberDTO)
        
        
        //3. Assert
        let model = try XCTUnwrap(viewModel)
        XCTAssertEqual(model.date, numberDTO.date)
        XCTAssertEqual(model.type, .number)
        XCTAssertEqual(model.name, numberDTO.number)
        //...
    }

}
