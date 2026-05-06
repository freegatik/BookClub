//
//  BookmarksViewModel.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import Foundation
import SwiftUI

@MainActor
final class BookmarksViewModel: ObservableObject {

    // MARK: - Public Properties

    @Published var currentBook: CurrentBook
    @Published var favoriteBooks: [FavoriteBook]
    @Published var quotes: [Quote]
    @Published var selectedBook: BookDetails?
    @Published var isBookDetailsPresented: Bool = false

    // MARK: - Private Properties

    private let dataProvider: BookmarksDataProviding

    // MARK: - Init

    init(
        currentBook: CurrentBook? = nil,
        favoriteBooks: [FavoriteBook]? = nil,
        quotes: [Quote]? = nil,
        dataProvider: BookmarksDataProviding = MockBookmarksDataProvider()
    ) {
        self.dataProvider = dataProvider
        let snapshot = dataProvider.makeBookmarksSnapshot()
        self.currentBook = currentBook ?? snapshot.currentBook
        self.favoriteBooks = favoriteBooks ?? snapshot.favoriteBooks
        self.quotes = quotes ?? snapshot.quotes
    }

    // MARK: - Public Methods

    func loadData() {
        let snapshot = dataProvider.makeBookmarksSnapshot()
        currentBook = snapshot.currentBook
        favoriteBooks = snapshot.favoriteBooks
        quotes = snapshot.quotes
    }

    func showBookDetails(for book: FavoriteBook) {
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
                Chapter(title: "Пролог", isRead: true, isReading: false),
                Chapter(title: "Глава 1", isRead: true, isReading: false),
                Chapter(title: "Глава 2", isRead: false, isReading: true),
                Chapter(title: "Глава 3", isRead: false, isReading: false),
                Chapter(title: "Глава 4", isRead: false, isReading: false)
            ]
        )
        isBookDetailsPresented = true
    }

    func showCurrentBookDetails() {
        selectedBook = BookDetails(
            coverImageName: currentBook.imageName,
            title: currentBook.title,
            author: "Дэн Браун",
            description: """
            Секретный код скрыт в работах Леонардо да Винчи...
            Только он поможет найти христианские святыни, дающие немыслимые власть и могущество...
            Ключ к величайшей тайне, над которой человечество билось веками, наконец может быть найден...
            """,
            progress: currentBook.progress,
            chapters: [
                Chapter(title: currentBook.chapter, isRead: false, isReading: true),
                Chapter(title: "Глава 1", isRead: false, isReading: false),
                Chapter(title: "Глава 2", isRead: false, isReading: false),
                Chapter(title: "Глава 3", isRead: false, isReading: false),
                Chapter(title: "Глава 4", isRead: false, isReading: false),
                Chapter(title: "Глава 5", isRead: false, isReading: false),
                Chapter(title: "Глава 6", isRead: false, isReading: false)
            ]
        )
        isBookDetailsPresented = true
    }
}
