//
//  PasePage.swift
//  BookNookUITests
//
//  Created by Anton Solovev on 15.01.2025.
//

import XCTest

class BasePage {
    // MARK: - Properties
    let app: XCUIApplication
    
    // MARK: - Init
    init(app: XCUIApplication) {
        self.app = app
    }
    
    // MARK: - Common Methods
    func waitForElement(_ element: XCUIElement, timeout: TimeInterval = 5) -> Bool {
        return element.waitForExistence(timeout: timeout)
    }
    
    func tapElement(_ element: XCUIElement) {
        if waitForElement(element) {
            element.tap()
        }
    }
    
    func hideKeyboard() {
        app.keyboards.buttons["Return"].tap()
    }
    
    func enterText(_ text: String, in element: XCUIElement) {
        if waitForElement(element) {
            element.tap()
            element.typeText(text)
            hideKeyboard()
        }
    }
    
    func clearAndEnterText(_ text: String, in element: XCUIElement) {
        if waitForElement(element) {
            element.tap()
            element.clearText()
            element.typeText(text)
        }
    }
    
    func isElementEnabled(_ element: XCUIElement) -> Bool {
        return waitForElement(element) && element.isEnabled
    }
    
    func isElementExists(_ element: XCUIElement) -> Bool {
        return element.exists
    }
    
    func getText(from element: XCUIElement) -> String? {
        return waitForElement(element) ? (element.value as? String) : nil
    }
}

// MARK: - XCUIElement Extensions
extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }
        
        tap()
        press(forDuration: 1.0)
        
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        typeText(deleteString)
    }
}
