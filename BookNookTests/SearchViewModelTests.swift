//
//  SearchViewModelTests.swift
//  BookNookTests
//
//  Created by Anton Solovev on 15.01.2025.
//

import XCTest
@testable import BookNook

private struct StubSearchDataProvider: SearchDataProviding {
    let catalog: SearchCatalog
    func makeInitialCatalog() -> SearchCatalog { catalog }
}

@MainActor
final class SearchViewModelTests: XCTestCase {
    func testRemoveRequestUpdatesList() {
        let r1 = Request(title: "A")
        let r2 = Request(title: "B")
        let catalog = SearchCatalog(
            searchResults: [],
            requests: [r1, r2],
            genres: [],
            authors: []
        )
        let sut = SearchViewModel(dataProvider: StubSearchDataProvider(catalog: catalog))
        XCTAssertEqual(sut.requests.count, 2)

        sut.removeRequest(r1)

        XCTAssertEqual(sut.requests.count, 1)
        XCTAssertEqual(sut.requests.first?.title, "B")
    }

    func testLoadDataRefreshesFromProvider() {
        let first = SearchCatalog(searchResults: [], requests: [Request(title: "one")], genres: [], authors: [])
        let second = SearchCatalog(searchResults: [], requests: [Request(title: "two")], genres: [], authors: [])
        var call = 0
        let provider = CallbackSearchDataProvider {
            call += 1
            return call == 1 ? first : second
        }
        let sut = SearchViewModel(dataProvider: provider)
        XCTAssertEqual(sut.requests.map(\.title), ["one"])

        sut.loadData()

        XCTAssertEqual(sut.requests.map(\.title), ["two"])
    }

    func testInitialStateLoadsFullCatalogFromProvider() {
        let catalog = SearchCatalog(
            searchResults: [SearchResult(imageName: "i", title: "T", author: "A")],
            requests: [Request(title: "r")],
            genres: [Genre(title: "g")],
            authors: [Author(imageName: "ia", title: "at")]
        )
        let sut = SearchViewModel(dataProvider: StubSearchDataProvider(catalog: catalog))

        XCTAssertEqual(sut.searchResults.count, 1)
        XCTAssertEqual(sut.searchResults.first?.title, "T")
        XCTAssertEqual(sut.requests.count, 1)
        XCTAssertEqual(sut.genres.count, 1)
        XCTAssertEqual(sut.authors.count, 1)
    }

    func testShowBookDetailsSetsSelectionAndPresentation() throws {
        let catalog = SearchCatalog(
            searchResults: [SearchResult(imageName: "Cover", title: "Da Vinci", author: "Brown")],
            requests: [],
            genres: [],
            authors: []
        )
        let sut = SearchViewModel(dataProvider: StubSearchDataProvider(catalog: catalog))
        let pick = sut.searchResults.first!

        sut.showBookDetails(for: pick)

        XCTAssertTrue(sut.isBookDetailsPresented)
        XCTAssertEqual(sut.selectedBook?.title, "Da Vinci")
        XCTAssertEqual(sut.selectedBook?.author, "Brown")
        XCTAssertEqual(sut.selectedBook?.coverImageName, "Cover")
        let progress = try XCTUnwrap(sut.selectedBook?.progress)
        XCTAssertEqual(progress, 0.3, accuracy: 0.001)
        XCTAssertEqual(sut.selectedBook?.chapters.count, 5)
        XCTAssertEqual(sut.selectedBook?.chapters.first?.title, "Пролог")
    }
}

private struct CallbackSearchDataProvider: SearchDataProviding {
    let next: () -> SearchCatalog
    func makeInitialCatalog() -> SearchCatalog { next() }
}
