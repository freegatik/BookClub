//
//  SignInViewModelTests.swift
//  BookNookTests
//
//  Created by Anton Solovev on 15.01.2025.
//

import XCTest
@testable import BookNook

@MainActor
final class SignInViewModelTests: XCTestCase {
    func testSignInReturnsFalseWhenInvalid() {
        let sut = SignInViewModel()
        sut.email = "bad"
        sut.password = "secret"
        XCTAssertFalse(sut.signIn())
    }

    func testSignInReturnsTrueWhenCredentialsValid() {
        let sut = SignInViewModel()
        sut.email = "user@test.com"
        sut.password = "secret"
        XCTAssertTrue(sut.signIn())
    }

    func testButtonActivatesWhenEmailAndPasswordBecomeValid() {
        let sut = SignInViewModel()
        XCTAssertFalse(sut.isButtonActive)

        sut.email = "user@test.com"
        XCTAssertFalse(sut.isButtonActive)

        sut.password = "x"
        XCTAssertTrue(sut.isButtonActive)
    }

    func testTogglePasswordVisibility() {
        let sut = SignInViewModel()
        XCTAssertFalse(sut.isPasswordVisible)
        sut.isPasswordVisible = true
        XCTAssertTrue(sut.isPasswordVisible)
    }

    func testCarouselUsesThreePlaceholderImages() {
        let sut = SignInViewModel()
        XCTAssertEqual(sut.carouselImages.count, 3)
    }
}
