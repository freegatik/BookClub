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
    
    // MARK: - Init
    
    init(
        currentBook: CurrentBook? = nil,
        favoriteBooks: [FavoriteBook]? = nil,
        quotes: [Quote]? = nil
    ) {
        self.currentBook = currentBook ?? SampleData.currentBook
        self.favoriteBooks = favoriteBooks ?? SampleData.favoriteBooks
        self.quotes = quotes ?? SampleData.quotes
    }
    
    // MARK: - Public Methods
    
    func loadData() {
        self.currentBook = SampleData.currentBook
        self.favoriteBooks = SampleData.favoriteBooks
        self.quotes = SampleData.quotes
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

// MARK: - Sample Data

extension BookmarksViewModel {
    enum SampleData {
        static let currentBook = CurrentBook(
            imageName: "TestBook2",
            title: "Код да винчи",
            chapter: "Пролог",
            progress: 0.2
        )
        
        static let favoriteBooks: [FavoriteBook] = [
            FavoriteBook(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист"),
            FavoriteBook(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист"),
            FavoriteBook(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист"),
            FavoriteBook(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист")
        ]
        
        static let quotes: [Quote] = [
            Quote(text: "Я все еще жив, да да я серьезно все еще живой, я надеюсь успею дописать проект, у меня осталось 2 дня как так", title: "Жизнь мобильщика", author: "Anton Solovev"),
            Quote(text: "Я все еще жив, да да я серьезно все еще живой, я надеюсь успею дописать проект, у меня осталось 2 дня как так", title: "Жизнь мобильщика", author: "Anton Solovev"),
            Quote(text: "Я все еще жив, да да я серьезно все еще живой, я надеюсь успею дописать проект, у меня осталось 2 дня как так", title: "Жизнь мобильщика", author: "Anton Solovev"),
            Quote(text: "Я все еще жив, да да я серьезно все еще живой, я надеюсь успею дописать проект, у меня осталось 2 дня как так", title: "Жизнь мобильщика", author: "Anton Solovev"),
            Quote(text: "Я все еще жив, да да я серьезно все еще живой, я надеюсь успею дописать проект, у меня осталось 2 дня как так", title: "Жизнь мобильщика", author: "Anton Solovev"),
            Quote(text: "Я все еще жив, да да я серьезно все еще живой, я надеюсь успею дописать проект, у меня осталось 2 дня как так", title: "Жизнь мобильщика", author: "Anton Solovev")
        ]
    }
}
