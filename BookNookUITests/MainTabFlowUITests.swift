//
//  MainTabFlowUITests.swift
//  BookNookUITests
//
//  Created by Anton Solovev on 15.01.2025.
//

import XCTest

/// End-to-end smoke: sign-in, tab bar navigation, search query drives filtered grid.
final class MainTabFlowUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication(bundleIdentifier: "com.apple.springboard").activate()

        app = XCUIApplication()
        app.launchArguments += ["-AppleLanguages", "(en)", "-AppleLocale", "en_US"]
        app.launch()

        let signInPage = SignInPage(app: app)
        signInPage.enterCredentials(email: "test@example.com", password: "password123")
        signInPage.tapSignIn()

        XCTAssertTrue(app.scrollViews["libraryRoot"].waitForExistence(timeout: 10))
    }

    override func tearDownWithError() throws {
        XCUIApplication(bundleIdentifier: "com.apple.springboard").activate()
        app = nil
    }

    func testNavigateBetweenLibrarySearchBookmarks() throws {
        XCTAssertTrue(app.buttons["tabSearch"].waitForExistence(timeout: 5))
        app.buttons["tabSearch"].tap()
        XCTAssertTrue(app.scrollViews["searchRoot"].waitForExistence(timeout: 5))

        app.buttons["tabBookmarks"].tap()
        XCTAssertTrue(app.scrollViews["bookmarksRoot"].waitForExistence(timeout: 5))

        app.buttons["tabLibrary"].tap()
        XCTAssertTrue(app.scrollViews["libraryRoot"].waitForExistence(timeout: 5))
    }

    func testSearchFieldFiltersVisibleResults() throws {
        app.buttons["tabSearch"].tap()
        XCTAssertTrue(app.scrollViews["searchRoot"].waitForExistence(timeout: 5))

        let searchField = app.searchFields.element(boundBy: 0)
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        searchField.tap()
        searchField.typeText("Swift")

        let cellLabel = app.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", "SWIFT")).element(boundBy: 0)
        XCTAssertTrue(cellLabel.waitForExistence(timeout: 8))
    }
}
