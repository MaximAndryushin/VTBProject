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
    
    // MARK: - EmailValidationAPI
    
    func testEmailValidationNewtorkManagerWrongInput() throws {
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
    
    
    func testEmailValidationNetworkManager() throws {
        //1. Assemble
        let mock = EmailValidationNetworkManager()
        let promise = self.expectation(description: "Request")
        var response: String?
        var responseError: String?
        
        
        //2. Activate
        mock.getInfo(about: "m.andryushin@mail.ru", completion: { data, error in
           
            responseError = error
            
            if let email = data {
                response = email.result
            }
            
            promise.fulfill()
            
        })
        
        
        //3. Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertEqual(response, "valid")
    }

    
    // MARK: - NumberValidationNetworkManager
    
    func testNumberValidationNewtorkManager() throws {
        //1. Assemble
        let mock = NumberNetworkManager()
        let promise = self.expectation(description: "Request")
        var valid: Bool = false
        var responseError: String?
        
        
        //2. Activate
        mock.getInfo(about: "+79102382390", completion: { data, error in
           
            responseError = error
            
            if let number = data {
                valid = number.valid
            }
            
            promise.fulfill()
            
        })
        
        
        //3. Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(responseError)
        XCTAssert(valid)
    }
    
    
    // MARK: - IconNetworkManager
    
    func testIconNewtorkManager() throws {
        //1. Assemble
        let mock = ImageDownloadManager()
        let promise = self.expectation(description: "Request")
        var responseError: String?
        var image: UIImage?
        
        
        //2. Activate
        mock.getIcon(name: "https://million-wallpapers.ru/wallpapers/1/50/339646622751917/vodopad-v-tailande.jpg", completion: { data, error in
           
            responseError = error
            
            if let data = data {
                image = UIImage(data: data)
            }
            promise.fulfill()
            
        })
        
        
        //3. Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertNotNil(image)
    }
}
