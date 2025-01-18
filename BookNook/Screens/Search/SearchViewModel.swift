//
//  SearchViewModel.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {
    // MARK: - Public Properties
    @Published var searchResults: [SearchResult]
    @Published var requests: [Request]
    @Published var genres: [Genre]
    @Published var authors: [Author]

    @Published var selectedBook: BookDetails?
    @Published var isBookDetailsPresented: Bool = false

    // MARK: - Private Properties
    private let dataProvider: SearchDataProviding

    // MARK: - Init
    init(dataProvider: SearchDataProviding = MockSearchDataProvider()) {
        self.dataProvider = dataProvider
        let catalog = dataProvider.makeInitialCatalog()
        searchResults = catalog.searchResults
        requests = catalog.requests
        genres = catalog.genres
        authors = catalog.authors
    }

    // MARK: - Public Methods
    func loadData() {
        let catalog = dataProvider.makeInitialCatalog()
        searchResults = catalog.searchResults
        requests = catalog.requests
        genres = catalog.genres
        authors = catalog.authors
    }

    func showBookDetails(for book: SearchResult) {
        selectedBook = BookDetails(
            coverImageName: book.imageName,
            title: book.title,
            author: book.author,
            description: """
            Секретный код скрыт в работах Леонардо да Винчи...
            Только он поможет найти христианские святыни, дающие немыслимые власть и могущество...
            Ключ к величайшей тайне, над которой человечество билось веками, наконец может быть найден...
            """,
            progress: 0.3,
            chapters: [
                Chapter(title: "Пролог", isRead: false, isReading: true),
                Chapter(title: "Глава 1", isRead: false, isReading: false),
                Chapter(title: "Глава 2", isRead: false, isReading: false),
                Chapter(title: "Глава 3", isRead: false, isReading: false),
                Chapter(title: "Глава 4", isRead: false, isReading: false)
            ]
        )
        isBookDetailsPresented = true
    }

    func removeRequest(_ request: Request) {
        requests.removeAll { $0.id == request.id }
    }
}
