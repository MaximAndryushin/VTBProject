//
//  AppVTBTests.swift
//  AppVTBTests
//
//  Created by Maxim Andryushin on 31.08.2020.
//  Copyright © 2020 Maxim Andryushin. All rights reserved.
//

import XCTest
@testable import AppVTB

class AppVTBTests: XCTestCase {
    
    private var view: UIViewController?

    override func setUpWithError() throws {
        try super.setUpWithError()
        view = FavoritesAssembly.assembly()
    }

    override func tearDownWithError() throws {
        view = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        print(type(of: view))
    }

    func testPerformanceExample() throws {
        measure {
            print(type(of: view))
        }
    }

}
