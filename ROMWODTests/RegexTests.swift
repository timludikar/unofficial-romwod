//
//  RegexTests.swift
//  ROMWODTests
//
//  Created by Tim Ludikar on 2018-08-08.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import XCTest

class RegexTests: XCTestCase {
    let timestampRegex = "\\d{4}-\\d{2}-\\d{2}\\s\\d{2}:\\d{2}:\\d{2}\\s[+]\\d{4}"
    let unixTimestampRegex = "\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}.\\d{3}Z"
    let yyyymmddRegex = "\\d{4}-\\d{2}-\\d{1,2}"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNumberOfMatches() {
        let numberofMatches = Regex(timestampRegex).test(input: "2018-08-06 00:00:00 +0000")
        XCTAssertEqual(numberofMatches, 1)
    }
    
    func testNoNumberOfMatches() {
        let numberofMatches = Regex(timestampRegex).test(input: "2018-08-06T00:00:00.000Z")
        XCTAssertEqual(numberofMatches, 0)
    }
    
    func testTimeStampOperatorComparsion() {
        let dateRegex = Regex(unixTimestampRegex)
        let YYMMDD = Regex(yyyymmddRegex)
        let dateString = "2018-08-06T00:00:00.000Z"
        
        switch dateString {
        case dateRegex:
            XCTAssertTrue(true)
        case YYMMDD:
            XCTFail()
        default:
            XCTFail()
        }
    }
    
    func testYYMMDDOperatorComparion() {
        let dateRegex = Regex("\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}.\\d{3}Z")
        let YYMMDD = Regex("\\d{4}-\\d{2}-\\d{1,2}")
        let dateString = "2018-08-06"
        
        switch dateString {
        case dateRegex:
            XCTFail()
        case YYMMDD:
            XCTAssertTrue(true)
        default:
            XCTFail()
        }
    }
    
    func testYYMMDOperatorComparion() {
        let dateRegex = Regex("\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}.\\d{3}Z")
        let YYMMDD = Regex("\\d{4}-\\d{2}-\\d{1,2}")
        let dateString = "2018-08-6"
        
        switch dateString {
        case dateRegex:
            XCTFail()
        case YYMMDD:
            XCTAssertTrue(true)
        default:
            XCTFail()
        }
    }
    
    func testYYMMDDOperatorComparionDefault() {
        let dateRegex = Regex("\\d{4}-\\d{2}-\\d{2}\\s\\d{2}:\\d{2}:\\d{2}\\s[+]\\d{4}")
        let YYMMDD = Regex("\\d{4}-\\d{2}-\\d{1,2}")
        let dateString = "2018-08"
        
        switch dateString {
        case dateRegex:
            XCTFail()
        case YYMMDD:
            XCTFail()
        default:
            XCTAssertTrue(true)
        }
    }    
}
