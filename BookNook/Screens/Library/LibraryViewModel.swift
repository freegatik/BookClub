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
    
    // MARK: - Init
    init(books: [Book]? = nil) {
        self.books = books ?? SampleData.books
    }
    
    // MARK: - Public Methods
    func loadBooks() {
        self.books = SampleData.books
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

// MARK: - Sample Data
extension LibraryViewModel {
    enum SampleData {
        static let books: [Book] = [
            Book(imageName: "TestBook1", title: "ПОНЕДЕЛЬНИК НАЧИНАЕТСЯ В СУББОТУ", author: "Эрик Мария Ремарк"),
            Book(imageName: "TestBook2", title: "КОД ДА ВИНЧИ", author: "Дэн Браун"),
            Book(imageName: "TestBook3", title: "ПРЕСТУПЛЕНИЕ И НАКАЗАНИЕ", author: "Фёдор Достоевский"),
            Book(imageName: "TestBook1", title: "ПОНЕДЕЛЬНИК НАЧИНАЕТСЯ В СУББОТУ", author: "Эрик Мария Ремарк"),
            Book(imageName: "TestBook2", title: "КОД ДА ВИНЧИ", author: "Дэн Браун"),
            Book(imageName: "TestBook3", title: "ПРЕСТУПЛЕНИЕ И НАКАЗАНИЕ", author: "Фёдор Достоевский"),
            Book(imageName: "TestBook1", title: "ПОНЕДЕЛЬНИК НАЧИНАЕТСЯ В СУББОТУ", author: "Эрик Мария Ремарк"),
            Book(imageName: "TestBook2", title: "КОД ДА ВИНЧИ", author: "Дэн Браун"),
            Book(imageName: "TestBook3", title: "ПРЕСТУПЛЕНИЕ И НАКАЗАНИЕ", author: "Фёдор Достоевский"),
            Book(imageName: "TestBook1", title: "ПОНЕДЕЛЬНИК НАЧИНАЕТСЯ В СУББОТУ", author: "Эрик Мария Ремарк"),
            Book(imageName: "TestBook2", title: "КОД ДА ВИНЧИ", author: "Дэн Браун"),
            Book(imageName: "TestBook3", title: "ПРЕСТУПЛЕНИЕ И НАКАЗАНИЕ", author: "Фёдор Достоевский"),
            Book(imageName: "TestBook1", title: "ПОНЕДЕЛЬНИК НАЧИНАЕТСЯ В СУББОТУ", author: "Эрик Мария Ремарк"),
            Book(imageName: "TestBook2", title: "КОД ДА ВИНЧИ", author: "Дэн Браун"),
            Book(imageName: "TestBook3", title: "ПРЕСТУПЛЕНИЕ И НАКАЗАНИЕ", author: "Фёдор Достоевский")
        ]
    }
}
