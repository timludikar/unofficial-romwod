//
//  ROMWODUITests.swift
//  ROMWODUITests
//
//  Created by Tim Ludikar on 2018-07-10.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import XCTest

class ROMWODUITests: XCTestCase {
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//                let app = XCUIApplication()
        app = XCUIApplication()
        setupSnapshot(app)
//        app.launchArguments.append("--uitesting")

        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        snapshot("01IndexScreen")
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
