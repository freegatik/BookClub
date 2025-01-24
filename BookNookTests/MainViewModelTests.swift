//
//  MainViewModelTests.swift
//  BookNookTests
//
//  Created by Anton Solovev on 15.01.2025.
//

import XCTest
@testable import BookNook

@MainActor
final class MainViewModelTests: XCTestCase {
    func testInitialCurrentBookMatchesSample() {
        let sut = MainViewModel()
        XCTAssertEqual(sut.currentBook.title, BookDetailsViewModel.SampleData.book.title)
        XCTAssertEqual(sut.currentBook.author, BookDetailsViewModel.SampleData.book.author)
        XCTAssertEqual(sut.currentBook.progress, BookDetailsViewModel.SampleData.book.progress, accuracy: 0.001)
        XCTAssertEqual(sut.currentBook.chapters.count, BookDetailsViewModel.SampleData.book.chapters.count)
    }
}
