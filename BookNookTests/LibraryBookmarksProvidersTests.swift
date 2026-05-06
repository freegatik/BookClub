//
//  LibraryBookmarksProvidersTests.swift
//  BookNookTests
//
//  Created by Anton Solovev on 15.01.2025.
//

import XCTest
@testable import BookNook

private final class CountingLibraryProvider: LibraryDataProviding, @unchecked Sendable {
    var makeCatalogCalls = 0
    let books: [Book]

    init(books: [Book] = [Book(imageName: "x", title: "y", author: "z")]) {
        self.books = books
    }

    func makeLibraryCatalog() -> LibraryCatalog {
        makeCatalogCalls += 1
        return LibraryCatalog(books: books)
    }
}

private final class CountingBookmarksProvider: BookmarksDataProviding, @unchecked Sendable {
    var snapshotCalls = 0
    func makeBookmarksSnapshot() -> BookmarksSnapshot {
        snapshotCalls += 1
        return BookmarksSnapshot(
            currentBook: MockBookmarksDataProvider.sampleCurrentBook,
            favoriteBooks: [],
            quotes: []
        )
    }
}

@MainActor
final class LibraryBookmarksProvidersTests: XCTestCase {
    func testLibraryViewModelCallsProviderOnInitAndLoadBooks() {
        let provider = CountingLibraryProvider()
        let sut = LibraryViewModel(dataProvider: provider)

        XCTAssertEqual(provider.makeCatalogCalls, 1)
        XCTAssertEqual(sut.books.count, 1)

        sut.loadBooks()

        XCTAssertEqual(provider.makeCatalogCalls, 2)
    }

    func testBookmarksViewModelCallsProviderOnInitAndLoadData() {
        let provider = CountingBookmarksProvider()
        let sut = BookmarksViewModel(dataProvider: provider)

        XCTAssertEqual(provider.snapshotCalls, 1)

        sut.loadData()

        XCTAssertEqual(provider.snapshotCalls, 2)
        XCTAssertEqual(sut.favoriteBooks.count, 0)
    }
}
