//
//  BookmarksDataProviding.swift
//  BookNook
//
//  Created by Anton Solovev on 15.01.2025.
//

import Foundation

struct BookmarksSnapshot: Sendable {
    let currentBook: CurrentBook
    let favoriteBooks: [FavoriteBook]
    let quotes: [Quote]
}

protocol BookmarksDataProviding: Sendable {
    func makeBookmarksSnapshot() -> BookmarksSnapshot
}

struct MockBookmarksDataProvider: BookmarksDataProviding {
    func makeBookmarksSnapshot() -> BookmarksSnapshot {
        BookmarksSnapshot(
            currentBook: MockBookmarksDataProvider.sampleCurrentBook,
            favoriteBooks: MockBookmarksDataProvider.sampleFavoriteBooks,
            quotes: MockBookmarksDataProvider.sampleQuotes
        )
    }

    static let sampleCurrentBook = CurrentBook(
        imageName: "TestBook2",
        title: "Код да винчи",
        chapter: "Пролог",
        progress: 0.2
    )

    static let sampleFavoriteBooks: [FavoriteBook] = [
        FavoriteBook(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист"),
        FavoriteBook(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист"),
        FavoriteBook(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист"),
        FavoriteBook(imageName: "TestSearchBook", title: "Swift для детей", author: "Мэтт Маккарти, Глория Уинквист")
    ]

    static let sampleQuotes: [Quote] = [
        Quote(text: "Я все еще жив, да да я серьезно все еще живой, я надеюсь успею дописать проект, у меня осталось 2 дня как так", title: "Жизнь мобильщика", author: "Anton Solovev"),
        Quote(text: "Я все еще жив, да да я серьезно все еще живой, я надеюсь успею дописать проект, у меня осталось 2 дня как так", title: "Жизнь мобильщика", author: "Anton Solovev"),
        Quote(text: "Я все еще жив, да да я серьезно все еще живой, я надеюсь успею дописать проект, у меня осталось 2 дня как так", title: "Жизнь мобильщика", author: "Anton Solovev"),
        Quote(text: "Я все еще жив, да да я серьезно все еще живой, я надеюсь успею дописать проект, у меня осталось 2 дня как так", title: "Жизнь мобильщика", author: "Anton Solovev"),
        Quote(text: "Я все еще жив, да да я серьезно все еще живой, я надеюсь успею дописать проект, у меня осталось 2 дня как так", title: "Жизнь мобильщика", author: "Anton Solovev"),
        Quote(text: "Я все еще жив, да да я серьезно все еще живой, я надеюсь успею дописать проект, у меня осталось 2 дня как так", title: "Жизнь мобильщика", author: "Anton Solovev")
    ]
}
