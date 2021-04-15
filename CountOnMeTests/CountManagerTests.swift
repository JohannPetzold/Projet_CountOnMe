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
        XCTAssertEqual(elements, ["1", "+", "1", "=", "2"])
    }
    
    func testGivenSomeExpression_WhenGettingElements_ThenReturnArrayOfString() {
        let elements: [String] = manager.getElementsFromText(text: "1+ + 1")
        
        XCTAssertEqual(elements.first!, "")
    }
    
    func testGivenSomeExpression2_WhenGettingElements_ThenReturnArrayOfString() {
        let elements: [String] = manager.getElementsFromText(text: "abc + def = ghi")
        
        XCTAssertEqual(elements.first!, "")
    }
    
    func testGivenExpression_WhenCheckingLastElement_ThenReturnTrueIfLastIsNotOperator() {
        let expression = manager.lastElementIsNotOperator(text: "1 + 1")
        
        XCTAssertTrue(expression)
    }
    
    func testGivenExpression_WhenCheckingLastElement_ThenReturnFalseIfLastIsOperator() {
        let expression = manager.lastElementIsNotOperator(text: "1 +")
        
        XCTAssertFalse(expression)
    }
    
    func testGivenBadExpression_WhenCheckingLastElement_ThenReturnTrue() {
        let expression = manager.lastElementIsNotOperator(text: "abcd + 1")
        
        XCTAssertTrue(expression)
    }

    func testGivenExpressionWith3Elements_WhenCountingElements_ThenShouldGetTrue() {
        let expression = manager.expressionHasEnoughElement(text: "1 + 1")
        
        XCTAssertTrue(expression)
    }
    
    func testGivenExpressionWith2Elements_WhenCountingElements_ThenShouldGetFalse() {
        let expression = manager.expressionHasEnoughElement(text: "1 +")
        
        XCTAssertFalse(expression)
    }
    
    func testGivenBadExpression_WhenCountingElements_ThenShouldGetFalse() {
        let expression = manager.expressionHasEnoughElement(text: "abcd + bdef")
        
        XCTAssertFalse(expression)
    }
    
    func testGivenExpressionWith1Result_WhenCheckingIfHasResult_ThenReturnTrue() {
        let expression = manager.expressionHasResult(text: "1 + 1 = 2")
        
        XCTAssertTrue(expression)
    }
    
    func testGivenExpressionWith2Result_WhenCheckingIfHasResult_ThenReturnTrue() {
        let expression = manager.expressionHasResult(text: "1 + 1 = 2 =")
        
        XCTAssertTrue(expression)
    }
    
    func testGivenBadExpression_WhenCheckingIfHasResult_ThenReturnTrue() {
        let expression = manager.expressionHasResult(text: "abc + def = hij")
        
        XCTAssertTrue(expression)
    }
    
    func testGivenAdditionExpression_WhenDoingCalculation_ThenShouldGetResult() {
        let addition = manager.operationToReduce(text: "1 + 1")
        
        XCTAssertEqual(addition, "2")
    }
    
    func testGivenAdditionAndMultiplicationExpression_WhenDoingCalculation_ThenShouldGetResult() {
        let result = manager.operationToReduce(text: "1 + 2 × 2")
        
        XCTAssertEqual(result, "5")
    }
    
    func testGivenMultipleOperation_WhenDoingCalculation_ThenShouldGetResult() {
        let result = manager.operationToReduce(text: "1 + 3 × 5 ÷ 3 × 5 ÷ 4 - 6")
        
        XCTAssertEqual(result, "1")
    }
    
    func testGivenBadExpression_WhenDoingCalculation_ThenShouldGetError() {
        let expression = manager.operationToReduce(text: "abc + def")
        
        XCTAssertEqual(expression, "")
    }
    
    func testGivenExpressionDivideBy0_WhenDoingCalculation_ThenShouldReturnError() {
        let expression = manager.operationToReduce(text: "4 ÷ 0")
        
        XCTAssertEqual(expression, "error")
    }
    
    func testGivenExpression0DivideBy0_WhenDoingCalculation_ThenShouldReturnError() {
        let expression = manager.operationToReduce(text: "0 ÷ 0")
        
        XCTAssertEqual(expression, "error")
    }
}
