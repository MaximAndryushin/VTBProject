//
//  FavoritesScreenTests.swift
//  AppVTBTests
//
//  Created by Maxim Andryushin on 02.09.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import XCTest
@testable import AppVTB

final class FavoritesScreenTests: XCTestCase {
    
    private var view: UIViewController?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        view = FavoritesAssembly.assembly()
    }

    override func tearDownWithError() throws {
        view = nil
        try super.tearDownWithError()
    }

    func testView() throws {
        //1. Assemble
        

        //2. Activate
        
        
        //3. Assert
        
        
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
