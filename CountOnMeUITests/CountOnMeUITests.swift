//
//  CountOnMeUITests.swift
//  CountOnMeUITests
//
//  Created by Johann Petzold on 12/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest

class CountOnMeUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }
    
    func testAddNumber() throws {
        let app = XCUIApplication()
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        app.buttons["4"].tap()
        app.buttons["5"].tap()
        app.buttons["6"].tap()
        app.buttons["7"].tap()
        app.buttons["8"].tap()
        app.buttons["9"].tap()
        app.buttons["0"].tap()
    }
    
    func testDoAdditionWithTwoNumbers() throws {
        let app = XCUIApplication()
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["8"].tap()
        app.buttons["9"].tap()
        app.buttons["="].tap()
    }
    
    func testDoSubstractionWithTwoNumbers() throws {
        let app = XCUIApplication()
        let button = app.buttons["2"]
        button.tap()
        app.buttons["5"].tap()
        app.buttons["-"].tap()
        app.buttons["1"].tap()
        button.tap()
        app.buttons["="].tap()
    }
    
    func testDoMultiplicationWithTwoNumbers() throws {
        let app = XCUIApplication()
        let button = app.buttons["3"]
        button.tap()
        app.buttons["6"].tap()
        app.buttons["×"].tap()
        button.tap()
        app.buttons["="].tap()
    }
    
    func testDoDivisionWithTwoNumbers() throws {
        let app = XCUIApplication()
        let button = app.buttons["5"]
        app.buttons["9"].tap()
        button.tap()
        app.buttons["÷"].tap()
        button.tap()
        app.buttons["="].tap()
    }
}
