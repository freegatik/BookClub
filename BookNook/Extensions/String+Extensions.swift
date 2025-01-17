//
//  String+Extensions.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import Foundation

extension String {
    /// Разбивает строку на две части по пробелу
    func splitIntoLines() -> (first: String, second: String) {
        let components = self.split(separator: " ")
        
        if components.count > 1 {
            let firstLine = String(components[0])
            let secondLine = components.dropFirst().joined(separator: " ")
            return (firstLine, secondLine)
        } else {
            return (self, "")
        }
    }
    
    /// Разбивает строку на две части по указанному индексу
    func splitAtIndex(_ index: Int) -> (first: String, second: String) {
        guard index > 0 && index < self.count else {
            return (self, "")
        }
        
        let stringIndex = self.index(self.startIndex, offsetBy: index)
        let firstPart = String(self[..<stringIndex])
        let secondPart = String(self[stringIndex...])
        
        return (firstPart, secondPart)
    }
    
    /// Разбивает строку на две части по последнему вхождению символа
    func splitByLastOccurrence(of character: Character) -> (first: String, second: String) {
        guard let lastIndex = self.lastIndex(of: character) else {
            return (self, "")
        }
        
        let firstPart = String(self[..<lastIndex])
        let secondPart = String(self[self.index(after: lastIndex)...])
        
        return (firstPart, secondPart)
    }
}
