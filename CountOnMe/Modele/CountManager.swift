//
//  CountManager.swift
//  CountOnMe
//
//  Created by Johann Petzold on 12/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class CountManager {

    /* Isole les éléments du texte séparés par un espace */
    func getElementsFromText(text: String) -> [String] {
        return text.split(separator: " ").map { "\($0)" }
    }
    
    /* Vérifie que l'expression est correcte (ne se termine pas par un opérateur) */
    func expressionIsCorrect(text: String) -> Bool {
        let elements = getElementsFromText(text: text)
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }
    
    /* Vérifie que l'expression a bien 3 éléments ou plus */
    func expressionHaveEnoughElement(text: String) -> Bool {
        return getElementsFromText(text: text).count >= 3
    }
    
    /* Vérifie si le dernier élément n'est pas un opérateur */
    func canAddOperator(text: String) -> Bool {
        let elements = getElementsFromText(text: text)
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }
    
    /* Vérifie si l'expression contient un signe = */
    func expressionHaveResult(text: String) -> Bool {
        return text.firstIndex(of: "=") != nil
    }
    
    /* Réalise les calculs en isolant les éléments composants chaque opération
     À chaque calcul effectué, retire les 3 éléments le composant et ajoute le résultat à l'index 0 */
    func operationToReduce(text: String) -> [String]? {
        var operations = getElementsFromText(text: text)
        if expressionHaveEnoughElement(text: text) && !expressionHaveResult(text: text) {
            while operations.count > 1 {
                let left = Int(operations[0])!
                let operand = operations[1]
                let right = Int(operations[2])!
                
                let result: Int
                switch operand {
                case "+": result = left + right
                case "-": result = left - right
                case "×" : result = left * right
                case "÷": result = left / right
                default: return nil
                }
                
                operations = Array(operations.dropFirst(3))
                operations.insert("\(result)", at: 0)
            }
        } else {
            return nil
        }
        return operations
    }
}
