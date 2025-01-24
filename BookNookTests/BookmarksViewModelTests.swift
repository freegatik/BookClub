//
//  BookmarksViewModelTests.swift
//  BookNookTests
//
//  Created by Anton Solovev on 15.01.2025.
//

import XCTest
@testable import BookNook

@MainActor
final class BookmarksViewModelTests: XCTestCase {
    func testInitUsesSampleDefaultsWhenNil() {
        let sut = BookmarksViewModel()
        XCTAssertEqual(sut.currentBook.title, BookmarksViewModel.SampleData.currentBook.title)
        XCTAssertEqual(sut.favoriteBooks.count, BookmarksViewModel.SampleData.favoriteBooks.count)
        XCTAssertEqual(sut.quotes.count, BookmarksViewModel.SampleData.quotes.count)
    }

    func testLoadDataResetsPublishedStateToSample() {
        let sut = BookmarksViewModel(
            currentBook: CurrentBook(imageName: "x", title: "tmp", chapter: "c", progress: 0.5),
            favoriteBooks: [],
            quotes: []
        )
        sut.loadData()

        XCTAssertEqual(sut.currentBook.title, BookmarksViewModel.SampleData.currentBook.title)
        XCTAssertEqual(sut.favoriteBooks.count, BookmarksViewModel.SampleData.favoriteBooks.count)
        XCTAssertEqual(sut.quotes.count, BookmarksViewModel.SampleData.quotes.count)
    }

    func testShowBookDetailsForFavorite() {
        let sut = BookmarksViewModel()
        let fav = FavoriteBook(imageName: "img", title: "Fav Title", author: "Fav Author")

        sut.showBookDetails(for: fav)

        XCTAssertTrue(sut.isBookDetailsPresented)
        XCTAssertEqual(sut.selectedBook?.title, "Fav Title")
        XCTAssertEqual(sut.selectedBook?.author, "Fav Author")
        XCTAssertEqual(sut.selectedBook?.coverImageName, "img")
        XCTAssertEqual(sut.selectedBook?.chapters.count, 5)
    }

    func testShowCurrentBookDetailsUsesProgressAndChapter() throws {
        let current = CurrentBook(imageName: "cb", title: "Now", chapter: "Глава X", progress: 0.42)
        let sut = BookmarksViewModel(currentBook: current, favoriteBooks: [], quotes: [])

        sut.showCurrentBookDetails()

        XCTAssertTrue(sut.isBookDetailsPresented)
        XCTAssertEqual(sut.selectedBook?.title, "Now")
        XCTAssertEqual(sut.selectedBook?.author, "Дэн Браун")
        let progress = try XCTUnwrap(sut.selectedBook?.progress)
        XCTAssertEqual(progress, 0.42, accuracy: 0.001)
        XCTAssertEqual(sut.selectedBook?.chapters.first?.title, "Глава X")
        XCTAssertEqual(sut.selectedBook?.chapters.first?.isReading, true)
    }
}
