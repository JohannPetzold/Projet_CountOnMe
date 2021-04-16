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
    var result: XCUIElement!
    
    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
        result = app.textViews["resultTextView"]
    }
    
    func testAddNumber() throws {
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
        
        XCTAssertEqual(result.value as! String, "1234567890")
    }
    
    func testDoAdditionWithTwoNumbers() throws {
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["8"].tap()
        app.buttons["9"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(result.value as! String, "12 + 89 = 101")
    }
    
    func testDoSubtractionWithTwoNumbers() throws {
        let button = app.buttons["2"]
        button.tap()
        app.buttons["5"].tap()
        app.buttons["-"].tap()
        app.buttons["1"].tap()
        button.tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(result.value as! String, "25 - 12 = 13")
    }
    
    func testDoMultiplicationWithTwoNumbers() throws {
        let button = app.buttons["3"]
        button.tap()
        app.buttons["6"].tap()
        app.buttons["×"].tap()
        button.tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(result.value as! String, "36 × 3 = 108")
    }
    
    func testDoDivisionWithTwoNumbers() throws {
        let button = app.buttons["5"]
        app.buttons["9"].tap()
        button.tap()
        app.buttons["÷"].tap()
        button.tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(result.value as! String, "95 ÷ 5 = 19")
    }
    
    func testBeginWithOperatorError() throws {
        app.buttons["+"].tap()
        
        XCTAssertTrue(app.alerts["Zéro!"].staticTexts["Commencez avec un chiffre !"].exists)
    }
    
    func testAddSignOverSignError() throws {
        app.buttons["2"].tap()
        app.buttons["-"].tap()
        app.buttons["+"].tap()
        
        XCTAssertEqual(result.value as! String, "2 - ")
        XCTAssertTrue(app.alerts["Zéro!"].exists)
        XCTAssertTrue(app.alerts["Zéro!"].staticTexts["Un opérateur est déjà mis !"].exists)
    }
    
    func testTapEqualWhenExpressionIsNotCorrect() throws {
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(result.value as! String, "12 + ")
        XCTAssertTrue(app.alerts["Zéro!"].exists)
        XCTAssertTrue(app.alerts["Zéro!"].staticTexts["Entrez une expression correcte !"].exists)
    }
    
    func testTapEqualWhenExpressionHasNotEnoughElement() throws {
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(result.value as! String, "12")
        XCTAssertTrue(app.alerts["Zéro!"].exists)
        XCTAssertTrue(app.alerts["Zéro!"].staticTexts["Démarrez un nouveau calcul !"].exists)
    }
    
    func testTapEqualWhenEqualIsAlreadyThere() throws {
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(result.value as! String, "12 + 3 = 15")
        XCTAssertTrue(app.alerts["Zéro!"].exists)
        XCTAssertTrue(app.alerts["Zéro!"].staticTexts["Résultat déjà obtenu !"].exists)
    }
    
    func testMultipleOperationExpression() throws {
        app.buttons["9"].tap()
        app.buttons["8"].tap()
        app.buttons["-"].tap()
        app.buttons["3"].tap()
        app.buttons["×"].tap()
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["0"].tap()
        app.buttons["÷"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(result.value as! String, "98 - 3 × 7 + 30 ÷ 5 = 83")
    }
    
    func testDivideByZero() throws {
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        app.buttons["÷"].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(result.value as! String, "10 ÷ 0 = error")
    }
}
