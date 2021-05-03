//
//  ExtensionString.swift
//  CountOnMe
//
//  Created by Johann Petzold on 15/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

extension String {
    var isDigits: Bool {
        guard !self.isEmpty else { return false }
        return Double(self) != nil
    }
    
    var isOperationSign: Bool {
        guard !self.isEmpty else { return false }
        return self == "+" || self == "-" || self == "×" || self == "÷" || self == "="
    }
    
    var isPrioritySign: Bool {
        guard !self.isEmpty else { return false }
        return self == "×" || self == "÷"
    }
    
    var isDivide: Bool {
        guard !self.isEmpty else { return false }
        return self == "÷"
    }
    
    /* Case en Double puis vérifie si le nombre est entier */
    func truncateDigit() -> String {
        guard !self.isEmpty else { return self }
        if let truncateResult = Double(self) {
            let result = String(truncateResult)
            let elements = result.split(separator: ".").map { "\($0)" }
            if elements.count == 2 && elements.last! == "0" {
                return elements.first!
            } else {
                return result
            }
        }
        return self
    }
}
