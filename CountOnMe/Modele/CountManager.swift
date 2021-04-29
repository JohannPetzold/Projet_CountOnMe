//
//  CountManager.swift
//  CountOnMe
//
//  Created by Johann Petzold on 12/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

struct CountManager {

    /* Isole les éléments du texte séparés par un espace */
    func getElementsFromText(text: String) -> [String] {
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
    
    /* Vérifie que l'expression est correcte (ne se termine pas par un opérateur) */
    func lastElementIsNotOperator(text: String) -> Bool {
        let elements = getElementsFromText(text: text)
        return !elements.last!.isOperationSign
    }
    
    /* Vérifie que l'expression a bien 3 éléments ou plus */
    func expressionHasEnoughElement(text: String) -> Bool {
        return getElementsFromText(text: text).count >= 3
    }
    
    /* Vérifie si l'expression contient un signe = */
    func expressionHasResult(text: String) -> Bool {
        return text.firstIndex(of: "=") != nil
    }
    
    /* Réalise les calculs en isolant les éléments composants chaque opération
     Priorise les multiplications et divisions */
    func operationToReduce(text: String) -> String {
        var operations = getElementsFromText(text: text)
        while operations.count > 1 {
            let index = operationsContainPriority(operations: operations)
            let left = index != nil ? Int(operations[index! - 1])! : Int(operations[0])!
            let operand = index != nil ? operations[index!] : operations[1]
            let right = index != nil ? Int(operations[index! + 1])! : Int(operations[2])!
            let result: Int
            if operand.isDivide && (left == 0 || right == 0) {
                return "error"
            }
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "×" : result = left * right
            case "÷": result = left / right
            default: return ""
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
        return operations.first!
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
    
    /* Vérifie l'expression et renvoi un message d'erreur */
    func verifyOperationButton(text: String) -> String? {
        if !lastElementIsNotOperator(text: text) {
            return "Un opérateur est déjà mis !"
        }
        if expressionHasResult(text: text) {
           return "Commencez avec un chiffre !"
        }
        return nil
    }
    
    /* Vérifie l'expression et renvoi un message d'erreur */
    func verifyEqualButton(text: String) -> String? {
        if !lastElementIsNotOperator(text: text) {
            return "Entrez une expression correcte !"
        }
        if !expressionHasEnoughElement(text: text) {
            return "Démarrez un nouveau calcul !"
        }
        if expressionHasResult(text: text) {
            return "Résultat déjà obtenu !"
        }
        return nil
    }
}
