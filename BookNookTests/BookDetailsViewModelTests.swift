//
//  BookDetailsViewModelTests.swift
//  BookNookTests
//
//  Created by Anton Solovev on 15.01.2025.
//

import XCTest
@testable import BookNook

@MainActor
final class BookDetailsViewModelTests: XCTestCase {
    func testFormatsMultilineDescriptionOnInit() {
        let book = BookDetails(
            coverImageName: "c",
            title: "t",
            author: "a",
            description: """
            Line one

               Line two


            Line three
            """,
            progress: 0.5,
            chapters: []
        )
        let sut = BookDetailsViewModel(book: book)

        XCTAssertEqual(sut.formattedDescription, "Line one\n\nLine two\n\nLine three")
    }

    func testLoadDataRefreshesFormattedDescriptionAfterMutation() {
        let book = BookDetails(
            coverImageName: "c",
            title: "t",
            author: "a",
            description: "Only",
            progress: 0.1,
            chapters: []
        )
        let sut = BookDetailsViewModel(book: book)
        sut.book = BookDetails(
            coverImageName: "c",
            title: "t",
            author: "a",
            description: "A\n\nB",
            progress: 0.2,
            chapters: []
        )

        sut.loadData()

        XCTAssertEqual(sut.formattedDescription, "A\n\nB")
    }
}
