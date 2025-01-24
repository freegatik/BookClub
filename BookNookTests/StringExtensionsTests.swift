//
//  StringExtensionsTests.swift
//  BookNookTests
//
//  Created by Anton Solovev on 15.01.2025.
//

import XCTest
@testable import BookNook

final class StringExtensionsTests: XCTestCase {
    func testSplitIntoLinesTwoWords() {
        let result = "Hello world".splitIntoLines()
        XCTAssertEqual(result.first, "Hello")
        XCTAssertEqual(result.second, "world")
    }

    func testSplitIntoLinesSingleWord() {
        let result = "Hello".splitIntoLines()
        XCTAssertEqual(result.first, "Hello")
        XCTAssertEqual(result.second, "")
    }

    func testSplitAtIndexMiddle() {
        let result = "abcdef".splitAtIndex(3)
        XCTAssertEqual(result.first, "abc")
        XCTAssertEqual(result.second, "def")
    }

    func testSplitAtIndexInvalidReturnsWholeString() {
        XCTAssertEqual("hi".splitAtIndex(0).second, "")
        XCTAssertEqual("hi".splitAtIndex(99).second, "")
    }

    func testSplitByLastOccurrence() {
        let result = "a/b/c".splitByLastOccurrence(of: "/")
        XCTAssertEqual(result.first, "a/b")
        XCTAssertEqual(result.second, "c")
    }

    func testSplitByLastOccurrenceMissingSeparator() {
        let result = "nosep".splitByLastOccurrence(of: "/")
        XCTAssertEqual(result.first, "nosep")
        XCTAssertEqual(result.second, "")
    }
}
