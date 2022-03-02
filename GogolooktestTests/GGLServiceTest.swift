//
//  GGLServiceTest.swift
//  GogolooktestTests
//
//  Created by Chih-Yi Chiang on 2022/3/2.
//

import XCTest

class GGLServiceTest: XCTestCase {

    var animeService: GGLAnimeService!
    var mangaService: GGLMangaService!
    
    override func setUp() {
        super.setUp()
        animeService = GGLAnimeService()
        mangaService = GGLMangaService()
    }
    
    override func tearDown() {
        animeService = nil
        mangaService = nil
        super.tearDown()
    }
    
    func testFetchAnimesAPI() {
        var responseError: Error?
        let promise = expectation(description: "No anime.")
        
        animeService.fetchAnimesAPI(page: 1, subtype: "tv") { error, anime in
            if let error = error {
                responseError = error
            }
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError, "Response is error.")
    }
    
    func testFetchMangasAPI() {
        var responseError: Error?
        let promise = expectation(description: "No manga.")
        
        mangaService.fetchMangasAPI(page: 1, subtype: "manga") { error, manga in
            if let error = error {
                responseError = error
            }
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError, "Response is error.")
    }
    
}
