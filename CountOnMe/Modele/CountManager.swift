//
//  CountManager.swift
//  CountOnMe
//
//  Created by Johann Petzold on 12/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

struct CountManager {

    func verifyNumberButton(text: String, completion: (Bool) -> Void) {
        if expressionHasResult(text: text) {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func verifyDecimalButton(text: String, completion: (String?) -> Void) {
        if text == "" || expressionHasResult(text: text) || !canAddDecimalToNumber(text: text) {
            completion("Impossible d'ajouter une décimale !")
        } else {
            completion(nil)
        }
    }
    
    func verifyOperationButton(text: String, completion: (String?) -> Void) {
        if text == "" || expressionHasResult(text: text) {
            completion("Commencez avec un chiffre !")
        } else if lastElementIsOperator(text: text) {
            completion("Un opérateur est déjà mis !")
        } else if !lastElementIsValidDigit(text: text) {
            completion("Entrez un nombre valide !")
        } else {
            completion(nil)
        }
    }
    
    func verifyEqualButton(text: String, completion: (String?) -> Void) {
        if lastElementIsOperator(text: text) {
            completion("Entrez une expression correcte !")
        } else if !expressionHasEnoughElement(text: text) {
            completion("Démarrez un nouveau calcul !")
        } else if expressionHasResult(text: text) {
            completion("Résultat déjà obtenu !")
        } else if !lastElementIsValidDigit(text: text) {
            completion("Entrez un nombre valide !")
        } else {
            completion(nil)
        }
    }
    
    /* Réalise les calculs en isolant les éléments composants chaque opération
     Priorise les multiplications et divisions */
    func operationToReduce(text: String, completion: (String) -> Void) {
        var operations = getElementsFromText(text: text)
        while operations.count > 1 {
            let index = operationsContainPriority(operations: operations)
            let left = index != nil ? Decimal(string: operations[index! - 1])! : Decimal(string: operations[0])!
            let operand = index != nil ? operations[index!] : operations[1]
            let right = index != nil ? Decimal(string: operations[index! + 1])! : Decimal(string: operations[2])!
            let result: Decimal
            if operand.isDivide && (left == 0 || right == 0) {
                completion("error")
                return
            }
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "×" : result = left * right
            case "÷": result = left / right
            default:
                completion("")
                return
            }
            if index != nil {
                for _ in 1...3 {
                    operations.remove(at: index!-1)
                }
                operations.insert("\(result)", at: index!-1)
            } else {
                operations = Array(operations.dropFirst(3))
                operations.insert("\(result)", at: 0)
            }
        }
        completion(operations.first!.truncateDigit())
    }
    
    /* Vérifie si l'expression contient une opération prioritaire et renvoi son index */
    private func operationsContainPriority(operations: [String]) -> Int? {
        for index in 0..<operations.count {
            if index > 0 && index < operations.count {
                if operations[index].isPrioritySign && operations[index - 1].isDigits && operations[index + 1].isDigits {
                    return index
                }
            }
        }
        return nil
    }
    
    /* Isole les éléments du texte séparés par un espace */
    private func getElementsFromText(text: String) -> [String] {
        let elements = text.split(separator: " ").map { "\($0)" }
        for element in elements {
            if !verifyElement(text: element) {
                return [""]
            }
        }
        return elements
    }
    
    /* Vérifie si le texte est un nombre ou un signe */
    private func verifyElement(text: String) -> Bool {
        if text.isDigits || text.isOperationSign {
            return true
        }
        return false
    }
    
    /* Vérifie que l'expression est correcte (se termine par un opérateur) */
    private func lastElementIsOperator(text: String) -> Bool {
        let elements = getElementsFromText(text: text)
        if elements.last != nil {
            return elements.last!.isOperationSign
        }
        return false
    }
    
    /* Vérifie que le dernier élément de l'expression est un nombre et ne contient pas de . */
    private func canAddDecimalToNumber(text: String) -> Bool {
        let elements = getElementsFromText(text: text)
        if elements.last != nil {
            return elements.last!.isDigits && !elements.last!.contains(".")
        }
        return false
    }
    
    /* Vérifie que le dernier élément est un nombre valide */
    private func lastElementIsValidDigit(text: String) -> Bool {
        let elements = getElementsFromText(text: text)
        if elements.last != nil {
            let number = elements.last!
            if number.contains(".") {
                let components = number.split(separator: ".").map { "\($0)" }
                if components.count == 2 {
                    return true
                } else {
                    return false
                }
            }
        }
        return true
    }
    
    /* Vérifie que l'expression a bien 3 éléments ou plus */
    private func expressionHasEnoughElement(text: String) -> Bool {
        return getElementsFromText(text: text).count >= 3
    }
    
    /* Vérifie si l'expression contient un signe = */
    private func expressionHasResult(text: String) -> Bool {
        return text.firstIndex(of: "=") != nil
    }
}
