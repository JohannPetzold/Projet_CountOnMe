//
//  ViewControllerTests.swift
//  CountOnMeTests
//
//  Created by Johann Petzold on 12/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class ViewControllerTests: XCTestCase {

    var controller: ViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        controller = storyboard.instantiateInitialViewController() as? ViewController
    }
    
    // MARK: - tappedNumberButton
    func testGivenTextViewIsEmpty_WhenUseTappedNumberButton_ThenTextViewBecomeButtonTitle() {
        _ = controller.view
        
        controller.tappedNumberButton(controller.numberButtons[1])
        
        XCTAssertEqual(controller.textView.text, "1")
    }
    
    func testGivenTextViewIsOne_WhenUseTappedNumberButton_ThenTextViewBecomeEleven() {
        _ = controller.view
        controller.textView.text = "1"
        
        controller.tappedNumberButton(controller.numberButtons[1])
        
        XCTAssertEqual(controller.textView.text, "11")
    }
    
    func testGivenTextView_WhenUseTappedNumberButtonWithNoTitle_ThenTextViewStaySame() {
        _ = controller.view
        let button = UIButton()
        controller.textView.text = ""
        
        controller.tappedNumberButton(button)
        
        XCTAssertEqual(controller.textView.text, "")
    }
    
    // MARK: - tappedDecimalButton
    func testGivenTextViewIsEmpty_WhenTappedDecimalButton_ThenTextViewStaySame() {
        _ = controller.view
        controller.textView.text = ""
        
        controller.tappedDecimalButton(controller.decimalButton)
        
        XCTAssertEqual(controller.textView.text, "")
    }
    
    func testGivenTextViewEndWithOperator_WhenTappedDecimalButton_ThenTextViewStaySame() {
        _ = controller.view
        controller.textView.text = "1 + "
        
        controller.tappedDecimalButton(controller.decimalButton)
        
        XCTAssertEqual(controller.textView.text, "1 + ")
    }
    
    func testGivenTextViewEndWithNumber_WhenTappedDecimalButton_ThenNumberGetDecimal() {
        _ = controller.view
        controller.textView.text = "1"
        
        controller.tappedDecimalButton(controller.decimalButton)
        
        XCTAssertEqual(controller.textView.text, "1.")
    }
    
    func testGivenTextViewNumberAlreadyGotDecimal_WhenTappedDecimalButton_ThenTextViewStaySame() {
        _ = controller.view
        controller.textView.text = "1.2"
        
        controller.tappedDecimalButton(controller.decimalButton)
        
        XCTAssertEqual(controller.textView.text, "1.2")
    }
    
    // MARK: - tappedOperationButton
    func testGivenTextViewAlreadyHasOperator_WhenUseTappedOperationButton_ThenTextViewStaySame() {
        _ = controller.view
        controller.textView.text = "1 +"
        
        controller.tappedOperationButton(controller.operatorButtons[0])
        
        XCTAssertEqual(controller.textView.text, "1 +")
    }
    
    func testGivenTextViewAlreadyHasEqual_WhenUseTappedOperationButton_ThenTextViewStaySame() {
        _ = controller.view
        controller.textView.text = "1 + 1 = 2"
        
        controller.tappedOperationButton(controller.operatorButtons[2])
        
        XCTAssertEqual(controller.textView.text, "1 + 1 = 2")
    }
    
    func testGivenOperatorButtonHasNoTitle_WhenUseTappedOperationButton_ThenNothingChange() {
        _ = controller.view
        controller.textView.text = "1 + 1"
        let button = UIButton()
        
        controller.tappedOperationButton(button)
        
        XCTAssertEqual(controller.textView.text, "1 + 1")
    }
    
    func testGivenTextViewHasNoSign_WhenUseTappedOperationButton_ThenTextViewAppendButtonTitle() {
        _ = controller.view
        controller.textView.text = "10"
        
        controller.tappedOperationButton(controller.operatorButtons[0])
        
        XCTAssertEqual(controller.textView.text, "10 + ")
    }
    
    // MARK: - tappedEqualButton
    func testGivenTextViewHasCorrectExpression_WhenUseTappedEqualButton_ThenTextViewAppendResult() {
        _ = controller.view
        controller.textView.text = "23 - 10 × 5"
        
        controller.tappedEqualButton(UIButton())
        
        XCTAssertEqual(controller.textView.text, "23 - 10 × 5 = -27")
    }
    
    func testGivenExpressionIsNotCorrect_WhenUseTappedEqualButton_ThenTextViewStaySame() {
        _ = controller.view
        controller.textView.text = "10 ÷"
        
        controller.tappedEqualButton(UIButton())
        
        XCTAssertEqual(controller.textView.text, "10 ÷")
    }
    
    func testGivenExpressionHasNotEnoughElement_WhenUseTappedEqualButton_ThenTextViewStaySame() {
        _ = controller.view
        controller.textView.text = "1 1"
        
        controller.tappedEqualButton(UIButton())
        
        XCTAssertEqual(controller.textView.text, "1 1")
    }
    
    func testGivenExpressionHasResult_WhenUseTappedEqualButton_ThenTextViewStaySame() {
        _ = controller.view
        controller.textView.text = "1 + 1 = 2"
        
        controller.tappedEqualButton(UIButton())
        
        XCTAssertEqual(controller.textView.text, "1 + 1 = 2")
    }
    
    // MARK: - tappedEraseButton
    func testGivenExpression_WhenUseTappedEraseButton_ThenTextViewBecomeEmpty() {
        _ = controller.view
        controller.textView.text = "1 + 3 + 5"
        
        controller.tappedEraseButton(UIButton())
        
        XCTAssertEqual(controller.textView.text, "")
    }
}
