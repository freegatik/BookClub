//
//  SignInCredentialsValidatorTests.swift
//  BookNookTests
//
//  Created by Anton Solovev on 15.01.2025.
//

import XCTest
@testable import BookNook

final class SignInCredentialsValidatorTests: XCTestCase {
    func testEmptyFieldsDisabled() {
        XCTAssertFalse(SignInCredentialsValidator.canEnableSignIn(email: "", password: ""))
        XCTAssertFalse(SignInCredentialsValidator.canEnableSignIn(email: "a@b.co", password: ""))
        XCTAssertFalse(SignInCredentialsValidator.canEnableSignIn(email: "", password: "x"))
    }

    func testInvalidEmailDisabled() {
        XCTAssertFalse(SignInCredentialsValidator.canEnableSignIn(email: "invalid@email", password: "secret"))
        XCTAssertFalse(SignInCredentialsValidator.canEnableSignIn(email: "not-an-email", password: "secret"))
    }

    func testValidEmailAndPasswordEnables() {
        XCTAssertTrue(SignInCredentialsValidator.canEnableSignIn(email: "test@example.com", password: "password123"))
    }

    func testTrimsEmailWhitespace() {
        XCTAssertTrue(SignInCredentialsValidator.canEnableSignIn(email: "  test@example.com  ", password: "x"))
    }
}
