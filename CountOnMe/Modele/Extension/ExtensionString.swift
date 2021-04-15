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
        return !self.contains { Int(String($0)) == nil }
    }
    
    var isOperationSign: Bool {
        guard !self.isEmpty else { return false }
        return self == "+" || self == "-" || self == "×" || self == "÷" || self == "="
    }
    
    var isPriority: Bool {
        guard !self.isEmpty else { return false }
        return self == "×" || self == "÷"
    }
    
    var isDivide: Bool {
        guard !self.isEmpty else { return false }
        return self == "÷"
    }
}
