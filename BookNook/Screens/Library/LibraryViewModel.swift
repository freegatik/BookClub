//
//  LibraryViewModel.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import Foundation
import SwiftUI

@MainActor
final class LibraryViewModel: ObservableObject {
    // MARK: - Public Properties
    @Published var books: [Book]
    @Published var selectedBook: BookDetails?
    @Published var isBookDetailsPresented: Bool = false

    // MARK: - Private Properties
    private let dataProvider: LibraryDataProviding

    // MARK: - Init
    init(books: [Book]? = nil, dataProvider: LibraryDataProviding = MockLibraryDataProvider()) {
        self.dataProvider = dataProvider
        if let books {
            self.books = books
        } else {
            self.books = dataProvider.makeLibraryCatalog().books
        }
    }

    // MARK: - Public Methods
    func loadBooks() {
        books = dataProvider.makeLibraryCatalog().books
    }

    func showBookDetails(for book: Book) {
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
}
