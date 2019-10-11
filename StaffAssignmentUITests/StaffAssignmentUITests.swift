//
//  StaffAssignmentUITests.swift
//  StaffAssignmentUITests
//
//  Created by Jingmeng.Gan on 10/10/19.
//  Copyright © 2019 Jingmeng.Gan. All rights reserved.
//

import XCTest

class StaffAssignmentUITests: XCTestCase {

    override func setUp() {
        
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    // NOTE: for UI tests to work the keyboard of simulator must be on.
    // Keyboard shortcut COMMAND + SHIFT + K while simulator has focus
    func testOpenStaffDetails_whenClickItem_thenStaffDetailsViewOpened() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["soccer, table tennis, guitar, foosball, billard, badminton, games, coding, algorithm, drinking, hangout"]/*[[".cells.staticTexts[\"soccer, table tennis, guitar, foosball, billard, badminton, games, coding, algorithm, drinking, hangout\"]",".staticTexts[\"soccer, table tennis, guitar, foosball, billard, badminton, games, coding, algorithm, drinking, hangout\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Henry"].buttons["Staff"]/*@START_MENU_TOKEN@*/.press(forDuration: 0.8);/*[[".tap()",".press(forDuration: 0.8);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tablesQuery.staticTexts["Peter"].tap()
        
        XCTAssertTrue(app.navigationBars["Peter"].waitForExistence(timeout: 3))

    }
}
