//
//  GGLServiceTest.swift
//  GogolooktestTests
//
//  Created by Chih-Yi Chiang on 2022/3/2.
//

import XCTest
@testable import Gogolooktest

class GGLServiceTest: XCTestCase {

    var gglBoService: GGLBoServiceProtocol!
    
    override func setUp() {
        super.setUp()
        gglBoService = GGLBoService()
    }
    
    override func tearDown() {
        gglBoService = nil
        super.tearDown()
    }
    
    func testFetchGGLBosAPI() {
        var responseError: GGLServiceError?
        var boArray: [TopInfo]?
        let promise = expectation(description: "No ggl bo.")
        
        gglBoService.fetchGGLBoAPI(type: MainType.Anime.rawValue.lowercased(), page: 1, subtype: AnimeSubtype.tv.rawValue) { error, bo in
            if let error = error {
                responseError = error
            }
            else {
                boArray = bo
            }
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError, "Response is error.")
        
        XCTAssertNotNil(boArray, "Get 0 topinfos.")
    }
    
}
