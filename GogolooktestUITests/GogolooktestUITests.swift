//
//  GogolooktestUITests.swift
//  GogolooktestUITests
//
//  Created by Chih-Yi Chiang on 2022/3/2.
//

import XCTest

class GogolooktestUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testLike() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["GoButton"].tap()
        
        let verticalScrollBar7PagesCollectionViewsQuery = app.collectionViews.containing(.other, identifier:"Vertical scroll bar, 7 pages")
        verticalScrollBar7PagesCollectionViewsQuery.children(matching: .cell).element(boundBy: 0)/*@START_MENU_TOKEN@*/.buttons["LikeButton"]/*[[".buttons[\"love\"]",".buttons[\"LikeButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(1)
        verticalScrollBar7PagesCollectionViewsQuery.children(matching: .cell).element(boundBy: 1)/*@START_MENU_TOKEN@*/.buttons["LikeButton"]/*[[".buttons[\"love\"]",".buttons[\"LikeButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(1)
        verticalScrollBar7PagesCollectionViewsQuery.children(matching: .cell).element(boundBy: 2)/*@START_MENU_TOKEN@*/.buttons["LikeButton"]/*[[".buttons[\"love\"]",".buttons[\"LikeButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(1)
        verticalScrollBar7PagesCollectionViewsQuery.children(matching: .cell).element(boundBy: 3)/*@START_MENU_TOKEN@*/.buttons["LikeButton"]/*[[".buttons[\"love\"]",".buttons[\"LikeButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(1)
        verticalScrollBar7PagesCollectionViewsQuery.children(matching: .cell).element(boundBy: 4)/*@START_MENU_TOKEN@*/.buttons["LikeButton"]/*[[".buttons[\"love\"]",".buttons[\"LikeButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testDetail() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["GoButton"].tap()
        
        app.collectionViews.containing(.other, identifier:"Vertical scroll bar, 7 pages").children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
    }
    
    func testSubType() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["GoButton"].tap()
        
        let collectionViewsQuery = app.collectionViews.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["upcoming"]/*[[".cells.staticTexts[\"upcoming\"]",".staticTexts[\"upcoming\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(1)
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["tv"]/*[[".cells.staticTexts[\"tv\"]",".staticTexts[\"tv\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(1)
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["movie"]/*[[".cells.staticTexts[\"movie\"]",".staticTexts[\"movie\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(1)
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["special"]/*[[".cells.staticTexts[\"special\"]",".staticTexts[\"special\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(1)
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["favorite"]/*[[".cells.staticTexts[\"favorite\"]",".staticTexts[\"favorite\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
}
