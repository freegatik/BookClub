//
//  LibraryViewModelTests.swift
//  BookNookTests
//
//  Created by Anton Solovev on 15.01.2025.
//

import XCTest
@testable import BookNook

@MainActor
final class LibraryViewModelTests: XCTestCase {
    func testInitUsesInjectedBooks() {
        let custom = [
            Book(imageName: "a", title: "T1", author: "A1"),
            Book(imageName: "b", title: "T2", author: "A2"),
        ]
        let sut = LibraryViewModel(books: custom)
        XCTAssertEqual(sut.books.count, 2)
        XCTAssertEqual(sut.books.first?.title, "T1")
    }

    func testLoadBooksRestoresSampleCatalog() {
        let sut = LibraryViewModel(books: [])
        XCTAssertEqual(sut.books.count, 0)

        sut.loadBooks()

        XCTAssertEqual(sut.books.count, LibraryViewModel.SampleData.books.count)
        XCTAssertEqual(sut.books.first?.title, LibraryViewModel.SampleData.books.first?.title)
    }

    func testShowBookDetailsSetsPresentationAndMetadata() throws {
        let sut = LibraryViewModel(books: [])
        let book = Book(imageName: "Cover", title: "My Title", author: "My Author")

        sut.showBookDetails(for: book)

        XCTAssertTrue(sut.isBookDetailsPresented)
        XCTAssertEqual(sut.selectedBook?.title, "My Title")
        XCTAssertEqual(sut.selectedBook?.author, "My Author")
        XCTAssertEqual(sut.selectedBook?.coverImageName, "Cover")
        let progress = try XCTUnwrap(sut.selectedBook?.progress)
        XCTAssertEqual(progress, 0.3, accuracy: 0.001)
        XCTAssertEqual(sut.selectedBook?.chapters.count, 5)
    }
}
