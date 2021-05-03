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
    
    // MARK: - verifyNumberButton
    func testGivenExpressionWithResult_WhenUsingVerifyNumberButton_ThenReturnTrue() {
        manager.verifyNumberButton(text: "1 + 1 = 2") { result in
            XCTAssertTrue(result)
        }
    }
    
    func testGivenExpressionWithoutResult_WhenUsingVerifyNumberButton_ThenReturnFalse() {
        manager.verifyNumberButton(text: "1 + 1") { result in
            XCTAssertFalse(result)
        }
    }
    
    func testGivenWrongExpressionWithResult_WhenUsingVerifyNumberButton_ThenReturnTrue() {
        manager.verifyNumberButton(text: "abc = def + ghi") { result in
            XCTAssertTrue(result)
        }
    }
    
    // MARK: - verifyDecimalButton
    func testGivenExpressionEndWithNumber_WhenVerifyingDecimalButton_ThenReturnNil() {
        manager.verifyDecimalButton(text: "1 + 1") { error in
            XCTAssertNil(error)
        }
    }
    
    func testGivenExpressionEndWithOperator_WhenVerifyingDecimalButton_ThenReturnError() {
        manager.verifyDecimalButton(text: "1 -") { error in
            XCTAssertEqual(error, "Impossible d'ajouter une décimale !")
        }
    }
    
    func testGivenExpressionWithEqual_WhenVerifyingDecimalButton_ThenReturnError() {
        manager.verifyDecimalButton(text: "1 + 1 = 2") { error in
            XCTAssertEqual(error, "Impossible d'ajouter une décimale !")
        }
    }
    
    func testGivenEmptyExpression_WhenVerifyingDecimalButton_ThenReturnError() {
        manager.verifyDecimalButton(text: "") { error in
            XCTAssertNotNil(error)
        }
    }
    
    func testGivenExpressionWithDecimal_WhenVerifyingDecimalButton_ThenReturnError() {
        manager.verifyDecimalButton(text: "1.") { error in
            XCTAssertEqual(error, "Impossible d'ajouter une décimale !")
        }
    }
    
    // MARK: - verifyOperationButton
    func testGivenExpressionHasOperator_WhenVerifyingOperationButton_ThenReturnErrorMessage() {
        manager.verifyOperationButton(text: "1 +") { error in
            XCTAssertEqual(error, "Un opérateur est déjà mis !")
        }
    }
    
    func testGivenExpressionHasResult_WhenVerifyingOperationButton_ThenReturnErrorMessage() {
        manager.verifyOperationButton(text: "1 + 1 = 2") { error in
            XCTAssertEqual(error, "Commencez avec un chiffre !")
        }
    }
    
    func testGivenExpressionHasNoOperator_WhenVerifyOperationButton_ThenReturnNil() {
        manager.verifyOperationButton(text: "1") { error in
            XCTAssertNil(error)
        }
    }
    
    func testGivenExpressionEmpty_WhenVerifyOperationButton_ThenReturnErrorMessage() {
        manager.verifyOperationButton(text: "") { error in
            XCTAssertEqual(error, "Commencez avec un chiffre !")
        }
    }
    
    func testGivenExpressionWithNonValidNumber_WhenVerifyOperationButton_ThenReturnError() {
        manager.verifyOperationButton(text: "1.") { error in
            XCTAssertEqual(error, "Entrez un nombre valide !")
        }
    }
    
    // MARK: - verifyEqualButton
    func testGivenExpressionHasOperatorLast_WhenVerifyingEqualButton_ThenReturnError() {
        manager.verifyEqualButton(text: "1 +") { error in
            XCTAssertEqual(error, "Entrez une expression correcte !")
        }
    }
    
    func testGivenExpressionHasEnoughElement_WhenVerifyingEqualButton_ThenReturnError() {
        manager.verifyEqualButton(text: "1 1") { error in
            XCTAssertEqual(error, "Démarrez un nouveau calcul !")
        }
    }
    
    func testGivenExpressionHasResult_WhenVerifyingEqualButton_ThenReturnError() {
        manager.verifyEqualButton(text: "1 + 1 = 2") { error in
            XCTAssertEqual(error, "Résultat déjà obtenu !")
        }
    }
    
    func testGivenExpressionIsCorrect_WhenVerifyingEqualButton_ThenReturnNil() {
        manager.verifyEqualButton(text: "1 + 1") { error in
            XCTAssertNil(error)
        }
    }
    
    func testGivenExpressionEmpty_WhenVerifyingEqualButton_ThenReturnError() {
        manager.verifyEqualButton(text: "") { error in
            XCTAssertEqual(error, "Démarrez un nouveau calcul !")
        }
    }
    
    func testGivenExpressionWithNonValidDigit_WhenVerifyingEqualButton_ThenReturnError() {
        manager.verifyEqualButton(text: "1 + 1.") { error in
            XCTAssertEqual(error, "Entrez un nombre valide !")
        }
    }
    
    func testGivenExpressionWithDecimal_WhenVerifyingEqualButton_ThenReturnNil() {
        manager.verifyEqualButton(text: "1.5 + 1.5") { error in
            XCTAssertNil(error)
        }
    }
    
    // MARK: - operationToReduce
    func testGivenAdditionExpression_WhenDoingCalculation_ThenShouldGetResult() {
        manager.operationToReduce(text: "1 + 1") { result in
            XCTAssertEqual(result, "2")
        }
    }
    
    func testGivenAdditionAndMultiplicationExpression_WhenDoingCalculation_ThenShouldGetResult() {
        manager.operationToReduce(text: "1 + 2 × 2") { result in
            XCTAssertEqual(result, "5")
        }
    }
    
    func testGivenMultipleOperation_WhenDoingCalculation_ThenShouldGetResult() {
        manager.operationToReduce(text: "1 + 3 × 5 ÷ 3 × 5 ÷ 4 - 6") { result in
            XCTAssertEqual(result, "1.25")
        }
    }
    
    func testGivenBadExpression_WhenDoingCalculation_ThenShouldGetError() {
        manager.operationToReduce(text: "abc + def") { result in
            XCTAssertEqual(result, "")
        }
    }
    
    func testGivenExpressionDivideBy0_WhenDoingCalculation_ThenShouldReturnError() {
        manager.operationToReduce(text: "4 ÷ 0") { result in
            XCTAssertEqual(result, "error")
        }
    }
    
    func testGivenExpression0DivideBy0_WhenDoingCalculation_ThenShouldReturnError() {
        manager.operationToReduce(text: "0 ÷ 0") { result in
            XCTAssertEqual(result, "error")
        }
    }
    
}
