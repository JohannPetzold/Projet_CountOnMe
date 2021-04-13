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
    
    func testGivenTextViewIsBase_WhenUseTappedNumberButton_ThenTextViewBecomeButtonTitle() {
        let _ = controller.view
        
        controller.tappedNumberButton(controller.numberButtons[1])
        
        XCTAssertEqual(controller.textView.text, "1")
    }
    
    func testGivenTextViewAsNumber_WhenUseTappedNumberButton_ThenTextViewAddButtonTitleAtLast() {
        let _ = controller.view
        controller.textView.text = "1"
        
        controller.tappedNumberButton(controller.numberButtons[1])
        
        XCTAssertEqual(controller.textView.text, "11")
    }
    
    func testGivenTextView_WhenUseTappedNumberButtonWithNoTitle_ThenTextViewStaySame() {
        let _ = controller.view
        let button = UIButton()
        controller.textView.text = ""
        
        controller.tappedNumberButton(button)
        
        XCTAssertEqual(controller.textView.text, "")
    }
    
    func testGivenTextViewAlreadyHasOperator_WhenUseTappedOperationButton_ThenTextViewStaySame() {
        let _ = controller.view
        controller.textView.text = "1 +"
        
        controller.tappedOperationButton(controller.operatorButtons[0])
        
        XCTAssertEqual(controller.textView.text, "1 +")
    }
    
    func testGivenTextViewAlreadyHasEqual_WhenUseTappedOperationButton_ThenTextViewStaySame() {
        let _ = controller.view
        controller.textView.text = "1 + 1 = 2"
        
        controller.tappedOperationButton(controller.operatorButtons[2])
        
        XCTAssertEqual(controller.textView.text, "1 + 1 = 2")
    }
    
    func testGivenOperatorButtonHasNoTitle_WhenUseTappedOperationButton_ThenNothingChange() {
        let _ = controller.view
        controller.textView.text = "1 + 1"
        let button = UIButton()
        
        controller.tappedOperationButton(button)
        
        XCTAssertEqual(controller.textView.text, "1 + 1")
    }
    
    func testGivenTextViewHasNoSign_WhenUseTappedOperationButton_ThenTextViewAppendButtonTitle() {
        let _ = controller.view
        controller.textView.text = "10"
        
        controller.tappedOperationButton(controller.operatorButtons[0])
        
        XCTAssertEqual(controller.textView.text, "10 + ")
    }
    
    func testGivenTextViewHasCorrectExpression_WhenUseTappedEqualButton_ThenTextViewAppendResult() {
        let _ = controller.view
        controller.textView.text = "23 - 10 × 5"
        
        controller.tappedEqualButton(UIButton())
        
        XCTAssertEqual(controller.textView.text, "23 - 10 × 5 = 65")
    }
    
    func testGivenExpressionIsNotCorrect_WhenUseTappedEqualButton_ThenTextViewStaySame() {
        let _ = controller.view
        controller.textView.text = "10 ÷"
        
        controller.tappedEqualButton(UIButton())
        
        XCTAssertEqual(controller.textView.text, "10 ÷")
    }
    
    func testGivenExpressionHasNotEnoughElement_WhenUseTappedEqualButton_ThenTextViewStaySame() {
        let _ = controller.view
        controller.textView.text = "1 1"
        
        controller.tappedEqualButton(UIButton())
        
        XCTAssertEqual(controller.textView.text, "1 1")
    }
    
    func testGivenExpressionHasResult_WhenUseTappedEqualButton_ThenTextViewStaySame() {
        let _ = controller.view
        controller.textView.text = "1 + 1 = 2"
        
        controller.tappedEqualButton(UIButton())
        
        XCTAssertEqual(controller.textView.text, "1 + 1 = 2")
    }
}
