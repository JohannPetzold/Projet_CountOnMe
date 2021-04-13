//
//  CountManagerTests.swift
//  CountManagerTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountManagerTests: XCTestCase {

    var manager: CountManager!
    
    override func setUpWithError() throws {
        manager = CountManager()
    }
    
    func testGivenTextViewContainText_WhenGettingElements_ThenReturnArrayOfString() {
        let elements: [String] = manager.getElementsFromText(text: "1 + 1 = 2")
        
        XCTAssertNotNil(elements)
        XCTAssertEqual(elements.first!, "1")
    }
    
    func testGivenTwoTypeOfText_WhenCallingExpressionIsCorrect_ThenReturnFalseIfCalcSignIsAtEnd() {
        let firstText = manager.expressionIsCorrect(text: "1 + 1")
        let secondText = manager.expressionIsCorrect(text: "1 +")
        
        XCTAssertTrue(firstText)
        XCTAssertFalse(secondText)
    }

    func testGivenSomeTexts_WhenCountingElement_ThenShouldGetTrueWhenCountMoreOrEqualThan3() {
        let firstText = manager.expressionHaveEnoughElement(text: "1 + 1")
        let secondText = manager.expressionHaveEnoughElement(text: "1 +")
        
        XCTAssertTrue(firstText)
        XCTAssertFalse(secondText)
    }
    
    func testGivenSomeExpression_WhenCheckingLastElement_ThenShouldGetTrueIfNoCalcSign() {
        let firstText = manager.canAddOperator(text: "1 + 1")
        let secondText = manager.canAddOperator(text: "1 +")
        
        XCTAssertTrue(firstText)
        XCTAssertFalse(secondText)
    }
    
    func testGivenSomeExpressions_WhenCheckingIfContainsEqual_ThenReturnTrueIfSoAndFalseIfNot() {
        let firstText = manager.expressionHaveResult(text: "1 + 1 = 3")
        let secondText = manager.expressionHaveResult(text: "1 + 1")
        
        XCTAssertTrue(firstText)
        XCTAssertFalse(secondText)
    }
    
    func testGivenSomeExpressions_WhenCallingOperationToReduce_ThenGetResult() {
        let firstText = manager.operationToReduce(text: "1 + 1")
        let secondText = manager.operationToReduce(text: "1 +")
        let thirdText = manager.operationToReduce(text: "1 + 1 - 2 × 3 ÷ 4")
        let fourthText = manager.operationToReduce(text: "1 * 3")
        
        XCTAssertEqual(firstText!.first, "2")
        XCTAssertNil(secondText)
        XCTAssertEqual(thirdText!.first, "0")
        XCTAssertNil(fourthText)
    }
}
