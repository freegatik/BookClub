//
//  SignInPage.swift
//  BookNookUITests
//
//  Created by Anton Solovev on 15.01.2025.
//

import XCTest

final class SignInPage: BasePage {
    // MARK: - UI Elements
    private var carousel: XCUIElement { app.scrollViews["carouselView"] }
    private var emailField: XCUIElement { app.textFields["emailField"] }
    private var passwordField: XCUIElement { app.secureTextFields["passwordField"] }
    private var authButton: XCUIElement { app.buttons["authButton"] }
    
    // MARK: - Verification Methods
    func verifyElementsExist() -> Bool {
        return isElementExists(carousel) &&
               isElementExists(emailField) &&
               isElementExists(passwordField) &&
               isElementExists(authButton)
    }
    
    func isAuthButtonEnabled() -> Bool {
        return isElementEnabled(authButton)
    }
    
    func isCarouselEnabled() -> Bool {
        return isElementEnabled(carousel)
    }
    
    // MARK: - Action Methods
    func enterCredentials(email: String, password: String) {
        enterText(email, in: emailField)
        enterText(password, in: passwordField)
    }
    
    func tapSignIn() {
        tapElement(authButton)
    }
    
    func getEnteredEmail() -> String? {
        return getText(from: emailField)
    }
}
