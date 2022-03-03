//
//  GGLServiceTest.swift
//  GogolooktestTests
//
//  Created by Chih-Yi Chiang on 2022/3/2.
//

import XCTest

class GGLServiceTest: XCTestCase {

    var gglBoService: GGLBoService!
    
    override func setUp() {
        super.setUp()
        gglBoService = GGLBoService()
    }
    
    override func tearDown() {
        gglBoService = nil
        super.tearDown()
    }
    
    func testFetchGGLBosAPI() {
        var responseError: Error?
        let promise = expectation(description: "No ggl bo.")
        
        gglBoService.fetchGGLBoAPI(page: 1, subtype: "tv") { error, bo in
            if let error = error {
                responseError = error
            }
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError, "Response is error.")
    }
    
    
    
}
